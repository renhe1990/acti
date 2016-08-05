module Admin::WelcomeHelper
  SEARCH_OPTIONS = [
    ['我的课程', :course],
    ['公共课程', :public_course],
    ['试卷', :questionnaire],
    ['问卷', :poll]
  ]

  def search_select_tag(selected = nil)
    select_tag :type, options_for_select(SEARCH_OPTIONS, selected), class: 'form-control', style: 'width: 100%'
  end

  def search_tag(selected = nil)
    simple_form_for :search, url: searches_url, method: :get, html: { class: 'row form-inline' } do |f|
      concat(
        content_tag(:div, class: 'col-sm-2') do search_select_tag(selected) end
      )
      concat(
        content_tag(:div, class: 'col-sm-8') do
          text_field_tag :keyword, params[:keyword], class: 'form-control', style: 'width: 100%', placeholder: '请输入搜索关键字'
        end
      )
      concat(
        content_tag(:div, class: 'col-sm-2') do
          f.submit '搜索', class: 'btn btn-primary pull-right'
        end
      )
    end
  end

  GLOBAL_SEARCH_OPTIONS = [
    ['项目', :project],
    ['模块', :campaign],
    ['花絮', :feature],
    ['课程', :course],
    ['试卷', :questionnaire],
    ['问卷', :poll],
    ['评分', :opinionnaire],
    ['抽奖', :lucky_draw],
    ['演讲抽签', :speech_draw],
    ['辩论抽签', :debate_draw]
  ]

  def global_search_select_tag(selected = nil)
    select_tag :type, options_for_select(GLOBAL_SEARCH_OPTIONS, selected), class: 'form-control', style: 'width: 100%'
  end

  def global_search_tag(selected = nil)
    simple_form_for :search, url: admin_searches_url, method: :get, html: { class: 'row form-inline' } do |f|
      concat(
        content_tag(:div, class: 'col-sm-2') do global_search_select_tag(selected) end
      )
      concat(
        content_tag(:div, class: 'col-sm-8') do
          text_field_tag :keyword, params[:keyword], class: 'form-control', style: 'width: 100%', placeholder: '请输入搜索关键字'
        end
      )
      concat(
        content_tag(:div, class: 'col-sm-2') do
          f.submit '搜索', class: 'btn btn-primary pull-right'
        end
      )
    end
  end
end
