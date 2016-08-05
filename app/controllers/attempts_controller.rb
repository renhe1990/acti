class AttemptsController < BaseController
  before_action :find_survey

  skip_after_action :verify_authorized,  except: :index
  skip_after_action :verify_policy_scoped, only: :index

  def index
    @attempts = @survey.attempts
  end

  private
  def find_survey
    params.each do |name, value|
      if name =~ /(.+)_id$/
        @survey = $1.classify.constantize.includes(questions: [:options]).find(value)
        authorize @survey, :show?
      end
    end
  end
end
