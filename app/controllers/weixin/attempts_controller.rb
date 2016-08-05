class Weixin::AttemptsController < Weixin::BaseController
  before_action :find_survey, only: [:index, :new, :create, :show]

  include Weixin::InteractiveableController

  before_action :normalize_attempts_data, only: :create

  impressionist actions: [:index]

  def index
    @attempts = @survey.attempts
  end

  def new
    @attempt = @survey.attempts.new
    @attempt.answers.build

    impressionist(@survey, 'log impression', :unique => [:session_hash])
  end

  def create
    if @survey.type == 'Opinionnaire' && !@survey.ready_to_submit_for_user?(current_user)
      redirect_to weixin_opinionnaire_reviews_url(@survey), alert: '请完成所有的评分'
      return
    end

    @attempt = @survey.attempts.build(survey_attempt_params.merge(participant: current_user))
    if @attempt.valid? && @attempt.save
      case @survey.type
      when 'Questionnaire'
        redirect_to weixin_questionnaire_attempt_url(@survey, @attempt)
      when 'Poll'
        redirect_to weixin_poll_attempt_url(@survey, @attempt)
      when 'Opinionnaire'
        @survey.update_reviews_and_answers(current_user, @attempt.id)
        redirect_to weixin_opinionnaire_attempt_url(@survey, @attempt)
      end
    else
      render action: :new
    end
  end

  def show
    @attempt = @survey.attempts.find(params[:id])
  end

  protected
  def weixin_signed_in_required?
    @survey.course.campaign ? true : false
  end

  def weixin_binded_required?
    @survey.course.campaign ? true : false
  end

  private
  def find_survey
    params.each do |name, value|
      if name =~ /(.+)_id$/
        @survey = $1.classify.constantize.includes(:questions => :options).find(value)
      end
    end
  end

  def survey_attempt_params
    return {} if params[:survey_attempt].blank?

    @survey_attempt_params ||= params.require(:survey_attempt).permit(answers_attributes: [:question_id, :option_id, :text, :rating])
  end

  def normalize_attempts_data
    normalize_data!(params[:survey_attempt][:answers_attributes]) if params[:survey_attempt]
  end

  def normalize_data!(hash)
    multiple_answers = []
    last_key = hash.keys.last.to_i

    hash.keys.each do |k|
      if hash[k]['option_id'].is_a?(Array)
        if hash[k]['option_id'].size == 1
          hash[k]['option_id'] = hash[k]['option_id'][0]
          next
        else
          multiple_answers <<  k if hash[k]['option_id'].size > 1
        end
      end
    end

    multiple_answers.each do |k|
      hash[k]['option_id'][1..-1].each do |o|
      last_key += 1
      hash[last_key.to_s] = hash[k].merge('option_id' => o)
    end
      hash[k]['option_id'] = hash[k]['option_id'].first
    end
  end

  def participation_required
    return if anonymous_allowed?

    unless admin_allowed? || @survey.users.nil? || @survey.users.include?(current_user)
      redirect_to_participation_required_url
    end
  end

  def not_participated_required
    return if anonymous_allowed?

    attempt = Survey::Attempt.where(participant: current_user, survey: @survey).first
    if attempt
      redirect_to case @survey.type
                  when 'Questionnaire' then weixin_questionnaire_attempt_url(@survey, attempt)
                  when 'Poll' then weixin_poll_attempt_url(@survey, attempt)
                  when 'Opinionnaire' then weixin_opinionnaire_attempt_url(@survey, attempt)
                  end
    end
  end

  def anonymous_allowed?
    return false unless %w(Questionnaire Poll).include?(@survey.type)

    @survey.course.campaign ? false : true
  end
end
