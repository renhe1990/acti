class Admin::RepliesController < Admin::BaseController
  skip_after_action :verify_policy_scoped
  skip_after_action :verify_authorized
  before_action :set_admin_reply, only: [:show, :edit, :update, :destroy]

  def event
    @admin_reply = Admin::Reply.where(:category => "event").first
  end

  # GET /admin/replies
  def index
    @admin_replies = Admin::Reply.all
  end

  # GET /admin/replies/1
  def show
  end

  # GET /admin/replies/new
  def new
    @admin_reply = Admin::Reply.new
  end

  # GET /admin/replies/1/edit
  def edit
  end

  # POST /admin/replies
  def create
    @admin_reply = Admin::Reply.new(admin_reply_params)

    if @admin_reply.save
      redirect_to @admin_reply, notice: 'Reply was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/replies/1
  def update
    if @admin_reply.update(admin_reply_params)
      #redirect_to @admin_reply, notice: 'Reply was successfully updated.'
      #render :event ,notice: '更新成功'
      redirect_to event_admin_replies_path, notice: '更新成功'
    else
      render :edit
    end
  end

  # DELETE /admin/replies/1
  def destroy
    @admin_reply.destroy
    redirect_to admin_replies_url, notice: 'Reply was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_reply
      @admin_reply = Admin::Reply.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def admin_reply_params
      params.require(:admin_reply).permit(:category, :data)
    end
end
