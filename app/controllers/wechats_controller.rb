class WechatsController < ApplicationController
  skip_after_action :verify_authorized,  except: :index
  skip_after_action :verify_policy_scoped, only: :index

  skip_before_action :signed_in_required
  skip_before_action :teacher_required, only: [:new, :create]

  wechat_responder

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
    request.reply.text "欢迎关注“安利（中国）培训中心ACTI”，如果您是即将参加安利（中国）培训中心培训课程的学员，请您通过底部菜单“互动中心”—“绑定账号”进行绑定，用户名为您的安利卡号，密码为123。绑定成功后，点击“我的课程”—“项目列表”来查看您所参加培训课程的相关信息。如果您还不是我们的学员，欢迎您通过“了解ACTI”来了解安利（中国）培训中心方方面面，点点滴滴！"
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
