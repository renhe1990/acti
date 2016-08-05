class Weixin::AnswersController < Weixin::BaseController
  before_action :find_question

  def index
    @answers = policy_scope(Survey::Answer).by_question(@question).page(params[:page])
  end

  private
  def find_question
    @question = Survey::Question.find(params[:question_id])
  end
end
