class Admin::VotesController < Admin::BaseController
  include Admin::Sortable
  before_action :find_course
  before_action :find_and_authorize_vote, only: [:show, :edit, :update, :destroy]
  before_action :find_users, only: [:new, :create, :edit, :update]

  def index
    @votes = policy_scope(@course.votes).page(params[:page])
    authorize @votes
  end

  def new
    @vote = @course.votes.new
    authorize @vote
  end

  def create
    @vote = @course.votes.build(vote_params)
    authorize @vote

    if @vote.save
      redirect_to [:admin, @course, @vote], notice: '试卷创建成功'
    else
      render 'new'
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xls do
        filename = CGI::escape("投票-#{@vote.title}.xls")
        send_data @vote.to_xls, filename: filename
      end
    end
  end

  def edit
  end

  def update
    if @vote.update_attributes(vote_params)
      redirect_to [:admin, @course, @vote], notice: '试卷更新成功'
    else
      render 'edit'
    end
  end

  def destroy
    @vote.destroy
    redirect_to [:admin, @course, :votes]
  end

  private
  def find_course
    @course = Course.find(params[:course_id])
  end

  def find_and_authorize_vote
    @vote = @course.votes.find(params[:id])
    authorize @vote
  end

  def vote_params
    @vote_params ||= params.require(:vote).permit(:title, :description, :course_id, user_ids: [], vote_items_attributes: [:_destroy, :id, :title, :description, :position, vote_item_options_attributes: [:_destroy, :id, :text, :user_id]])
  end

  def find_users
    @lecturers = @course.lecturers.select(:id, :name).to_json
    @students = (@course.users ? @course.users.select(:id, :name) : []).to_json
  end
end
