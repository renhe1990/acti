module ActsAsSurvey
  extend ActiveSupport::Concern
  include Admin::Sortable

  included do
  end

  module ClassMethods
    def survey_options(hash = {})
    end
  end

  def qr_code
    @survey = Survey::Survey.find(params[:id])
    authorize @survey, :show?
    @url = case @survey.type
           when 'Questionnaire'
             new_weixin_questionnaire_attempt_url(@survey)
           when 'Poll'
             new_weixin_poll_attempt_url(@survey)
           end
    respond_to do |format|
      format.png { render qrcode: @url }
    end
  end

  private
  # def render(*args)
    # options = args.extract_options!
    # options[:template] = "/surveys/#{params[:action]}"
    # super(*(args << options))
  # end
end
