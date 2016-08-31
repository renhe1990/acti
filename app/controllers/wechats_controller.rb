class WechatsController < ActionController::Base
  skip_after_action :verify_authorized,  except: :index
  skip_after_action :verify_policy_scoped, only: :index

  skip_before_action :signed_in_required
  skip_before_action :teacher_required, only: [:new, :create]
  # For details on the DSL available within this file, see https://github.com/Eric-Guo/wechat#rails-responder-controller-dsl
  wechat_responder

  $redis=Redis.new

  on :text do |request, content|
    begin
		#puts "#{content}"
  		@l = $redis.keys("*"+"#{content}"+"*")
  		#puts @l.length
  		if  @l.length > 0
  			#@jsonString = '{"keyword":"新闻","reply":{"type":"graphic_text","content":[{"title":"新闻标题1","description":"描述1","pic":"http://image.tianjimedia.com/uploadImages/2012/231/59/W19D0E6GL776.jpg","url":"http://www.baidu.com"},{"title":"新闻标题2","description":"描述2","pic":"http://image.tianjimedia.com/uploadImages/2012/231/59/W19D0E6GL776.jpg","url":"http://www.baidu.com"}]}}'
  			#@jsonString = '{"keyword":"信息","reply":{"type":"text","content":"文本回复，文本测试中，"}}'
  			@keyword = @l.first
  			@jsonString = $redis.get(@keyword)
  			puts @jsonString
  			@jsonObject = JSON::parse(@jsonString)
  			@jsonObjectReply = @jsonObject['reply']		
  			@type = @jsonObjectReply['type']
  			#puts @type

  			#回复图文信息
  			if @type == 'graphic_text'
  				@jsonObjectContent = @jsonObjectReply['content']
  				request.reply.news(@jsonObjectContent) do |article, n, index| # 回复"articles"
			    	article.item title: n['title'], description: n['description'], pic_url: n['pic'], url: n['url']
			    end
  			#回复文本信息
  			else
  				@jsonObjectContent = @jsonObjectReply['content']
  				request.reply.text @jsonObjectReply['content']
  			end
  		else
  			request.reply.text $redis.get('sys_nomatch')	
  		end
    rescue Exception => e
      Rails.logger.error e
      request.reply.text '无法提供服务，请稍后重试'
    end
  end

  on :text, with: '账号绑定' do |request, help|
    begin
      if request[:FromUserName].present?
        request.reply.text "请访问这个链接进行绑定：http://acti.amway.com.cn/weixin/bindings/new?openid=#{request['FromUserName']}"
      else
        request.reply.text '无法进行绑定，请稍后重试'
      end
    rescue Exception => e
      Rails.logger.error e
      request.reply.text '无法进行绑定，请稍后重试'
    end
  end

  on :text, with: 'mp4 视频' do |request, help|
    video_article = VideoArticle.where(title: 'mp4 视频').first
    if video_article
      request.reply.text "http://acti.amway.com.cn/weixin/video_articles/#{video_article.id}"
    else
      request.reply.text '没有找到任何mp4 视频'
    end
  end

  on :text, with: 'avi 视频' do |request, help|
    video_article = VideoArticle.where(title: 'avi 视频').first
    if video_article
      request.reply.text "http://acti.amway.com.cn/weixin/video_articles/#{video_article.id}"
    else
      request.reply.text '没有找到任何avi 视频'
    end
  end

  on :text, with: '3gp 视频' do |request, help|
    video_article = VideoArticle.where(title: '3gp 视频').first
    if video_article
      request.reply.text "http://acti.amway.com.cn/weixin/video_articles/#{video_article.id}"
    else
      request.reply.text '没有找到任何3gp 视频'
    end
  end

  on :text, with: '花絮测试' do |request, help|
    feature = Feature.where(title: '花絮测试').first
    if feature
      request.reply.text "http://acti.amway.com.cn/weixin/features/#{feature.id}"
    else
      request.reply.text '没有找到任何花絮'
    end
  end

  on :text, with: '开发环境' do |request, help|
    request.reply.text 'http://18aa9196.ngrok.com/weixin'
  end

  on :text, with: '项目介绍' do |request, help|
    request.reply.text 'http://acti.amway.com.cn/weixin/pages/introduce'
  end

  on :text, with: '首页' do |request, help|
    request.reply.text "http://acti.amway.com.cn/weixin"
  end

  on :text, with: '动态首页' do |request, help|
    request.reply.text "http://acti.amway.com.cn/weixin/home"
  end

  on :text, with: '项目首页' do |request, help|
    if Project.count == 0
      request.reply.text '没有任何项目'
    else
      request.reply.text "http://acti.amway.com.cn/weixin/projects/#{Project.first.id}"
    end
  end

  on :text, with: /^项目(\d+)$/ do |request, count|
    project = Project.order("id ASC").all[count.to_i - 1]
    unless project
      request.reply.text '没有找到匹配的项目'
    else
      request.reply.text "http://acti.amway.com.cn/weixin/projects/#{project.id}"
    end
  end

  on :event, with: 'subscribe' do |request|
    logger.info 'user has just subscribed'
    # request.reply.text "请访问这个链接进行绑定：http://acti.amway.com.cn/weixin/bindings/new?openid=#{request['FromUserName']}"
    request.reply.text $redis.get('sys_event')
  end

  on :event, with: 'unsubscribe' do |request|
    logger.info 'user has just unsubscribed'
    user = User.where(uid: request[:FromUserName], provider: 'wechat').first
    logger.info user
    if user
      user.provider = nil
      user.uid = nil
      user.save(validate: false)
    end
  end

  on :event, with: 'CLICK' do |request|
    menu = Menu.find_by id: request[:EventKey].to_i
    if menu
      articles_range = (0...1)
      request.reply.news(articles_range) do |article, i|
        article.item title: menu.title, description: menu.description, pic_url: menu.image.url, url: menu.url
      end
    else
      request.reply.text "您访问的菜单已经不存在，请重新关注我们来更新菜单"
    end
  end

  on :event, with: 'VIEW' do |request|
    logger.info 'view'
    logger.info request
  end
end
