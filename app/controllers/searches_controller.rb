class SearchesController < ApplicationController
  skip_after_action :verify_policy_scoped

  def index
    @type = params[:type].presence

    if @type
      @searches = case @type.to_sym
        when :course
          current_user.courses.search(params[:keyword])
        when :public_course
          Course.common.search(params[:keyword], public: true)
        when :poll
          current_user.polls.search(params[:keyword])
        when :questionnaire
          current_user.questionnaires.search(params[:keyword])
        else
        end
    else
      redirect_to :back
    end
  end
end
