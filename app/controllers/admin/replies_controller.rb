class Admin::RepliesController < Admin::BaseController
  skip_after_action :verify_policy_scoped
  skip_after_action :verify_authorized
  before_action :set_admin_reply, only: [:show, :edit, :update, :destroy]

  $redis = Redis.new

  def event
    @admin_reply = Admin::Reply.where(:category => "event").first
  end

  def nomatch
    @admin_reply = Admin::Reply.where(:category => "nomatch").first
  end

  def text
  end

  def gettext
    @admin_reply = Admin::Reply.where(:category => "text").first
    if @admin_reply.present?
      render :json => @admin_reply.data
    elsif
      render :json => Admin::Reply.new.data
    end
  end
  
  def updatetext
	admin_reply = Admin::Reply.where(:category => "text").first
	if admin_reply.blank?
		admin_reply = Admin::Reply.create(:category => "text",:data => "")
	end
	if admin_reply.update(:category => params[:category],:data => params[:data])
    @result = initRedisData
		render :json => { :status => "1", :msg => "更新成功"}
	elsif
		render :json => {:status => "0", :msg => "更新失败"}
	end
  end
  
  def graphic_text
  end
  
  def get_graphic_text
    @admin_reply = Admin::Reply.where(:category => "graphic_text").first
    if @admin_reply.present?
      render :json => @admin_reply.data
    elsif
      render :json => Admin::Reply.new.data
    end
  end
  

  def update_graphic_text
	admin_reply = Admin::Reply.where(:category => "graphic_text").first
	if admin_reply.blank?
		admin_reply = Admin::Reply.create(:category => "graphic_text",:data => "")
	end
	if admin_reply.update(:category => params[:category],:data => params[:data])
    @result = initRedisData
		render :json => { :status => "1", :msg => "更新成功"}
	elsif
		render :json => {:status => "0", :msg => "更新失败"}
	end
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
      if @admin_reply.category == 'event'
        @result = initRedisData
        redirect_to event_admin_replies_path, notice: '更新成功'
      elsif @admin_reply.category == 'nomatch'
        @result = initRedisData
        redirect_to nomatch_admin_replies_path, notice: '更新成功'
      end
    else
      render :new
    end
  end

  # PATCH/PUT /admin/replies/1
  def update
    if @admin_reply.update(admin_reply_params)
      #redirect_to @admin_reply, notice: 'Reply was successfully updated.'
      #render :event ,notice: '更新成功'
      if @admin_reply.category == 'event'
        @result = initRedisData
        redirect_to event_admin_replies_path, notice: '更新成功'
      elsif @admin_reply.category == 'nomatch'
        @result = initRedisData
        redirect_to nomatch_admin_replies_path, notice: '更新成功'
      end
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

    def initRedisData
    @admin_replies = Admin::Reply.all
    begin
      if @admin_replies.length < 1
        return JSON.parse '{"success":"false"}' 
      end
    $redis.flushdb
    #puts @admin_replies.length
      for t in @admin_replies
        if t.category == 'event'
            #puts t.data
            $redis.set('sys_event',t.data)
        elsif t.category == 'nomatch'
            #puts t.data
            $redis.set('sys_nomatch',t.data)
        elsif (t.category == 'text' or t.category == 'graphic_text')
            #puts t.data
            @jsonObject = JSON::parse(t.data)
            if @jsonObject.length > 0 
                for i in @jsonObject
                  @keywordString = i['keyword']
                  @keywordString = @keywordString.gsub(',','|')
                  #puts @keywordString
                  @keywordArr = @keywordString.split('|')
                  #puts @keywordArr.length
                  for w in @keywordArr
                    $redis.set(w,i.to_json)
                  end
                end
            end
        else
            #puts t.data
        end
      end
      return JSON.parse '{"success":"true"}' 
    rescue Exception => e
      return JSON.parse '{"success":"false"}' 
    end
  end

end
