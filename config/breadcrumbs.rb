crumb :root do
  link "首页", root_url
end

crumb :courses do
  link '我的课程', courses_url
end

crumb :public_courses do
  link '公共课程', public_courses_url
end

crumb :public_course do |public_course|
  link public_course.name, public_course_url(public_course)
  parent :public_courses
end

crumb :my_courses do
  link '我的课程', courses_url
  parent :courses
end

crumb :new_course do
  link '发起新课程', new_course_url
  parent :my_courses
end

crumb :edit_course do |course|
  link '编辑课程', edit_course_url(course)
  parent :courses
end

crumb :course do |course|
  link '课程详情', course_url(course)
  parent :courses
end

crumb :interaction_management do
  link '互动管理'
end

crumb :my_lessons do
  link '我的课程', lessons_url
end

crumb :lesson do |lesson|
  link lesson.name, lesson_url(lesson)
  parent :my_lessons
end

crumb :questionnaires do |course|
  link '试卷管理', questionnaires_url
  parent :course, course
end

crumb :new_questionnaire do |course|
  link '创建试卷', new_questionnaire_url
  parent :course, course
end

crumb :edit_questionnaire do |course, questionnaire|
  link '编辑试卷', edit_questionnaire_url(questionnaire)
  parent :course, course
end

crumb :show_questionnaire do |course, questionnaire|
  link '试卷详情', questionnaire_url(questionnaire)
  if course.public
    parent :public_course, course
  else
    parent :course, course
  end
end

crumb :polls do |course|
  link '问卷管理', polls_url
  parent :course, course
end

crumb :new_poll do |course|
  link '创建问卷', new_poll_url
  parent :course, course
end

crumb :edit_poll do |course, poll|
  link '编辑问卷', edit_poll_url(poll)
  parent :course, course
end

crumb :show_poll do |course, poll|
  link '问卷详情', poll_url(poll)
  if course.public
    parent :public_course, course
  else
    parent :course, course
  end
end

crumb :admin_users do
  link '用户信息管理', admin_users_url
end

crumb :new_admin_user do
  link '添加用户', new_admin_user_url
  parent :admin_users
end

crumb :admin_user do |user|
  link '用户详情', admin_user_url(user)
  parent :admin_users
end

crumb :admin_articles do
  link '发布内容管理', admin_articles_url
end

crumb :new_admin_text_article do
  link '发布图文消息内容', new_admin_text_article_url
  parent :admin_articles
end

crumb :admin_text_article do |article|
  link '图文消息内容详情', admin_text_article_url(article)
  parent :admin_articles
end

crumb :edit_admin_text_article do |article|
  link '编辑图文消息内容', edit_admin_text_article_url(article)
  parent :admin_articles
end

crumb :new_admin_video_article do
  link '发布视频内容', new_admin_video_article_url
  parent :admin_articles
end

crumb :admin_video_article do |article|
  link '视频内容详情', admin_video_article_url(article)
  parent :admin_articles
end

crumb :edit_admin_video_article do |article|
  link '编辑视频内容', edit_admin_video_article_url(article)
  parent :admin_articles
end

crumb :admin_projects do
  link '项目管理', [:admin, :projects]
end

crumb :new_admin_project do
  link '新建项目', [:new, :admin, :project]
  parent :admin_projects
end

crumb :admin_project do |project|
  link '项目详情', [:admin, project]
  parent :admin_projects
end

crumb :edit_admin_project do |project|
  link '编辑项目', [:edit, :admin, project]
  parent :admin_project, project
end

crumb :admin_public_courses do
  link '公共课程管理', [:admin, :public_courses]
end

crumb :new_admin_public_course do
  link '新建公共课程', [:new, :admin, :public_course]
  parent :admin_public_courses
end

crumb :admin_public_course do |public_course|
  link '公共课程详情', [:admin, public_course]
  parent :admin_public_courses
end

crumb :edit_admin_public_course do |public_course|
  link '编辑公共课程', [:edit, :admin, public_course]
  parent :admin_public_course, public_course
end

crumb :admin_courses do |campaign|
  link '课程列表', [:admin, campaign, :courses]
  parent :admin_campaign, campaign.project, campaign
end

crumb :new_admin_course do |campaign|
  link '新建课程', [:new, :admin, campaign, :course]
  parent :admin_courses, campaign
end

crumb :admin_course do |campaign, course|
  link '课程详情', [:admin, campaign, course]
  parent :admin_courses, campaign
end

crumb :edit_admin_course do |campaign, course|
  link '编辑课程', [:edit, :admin, campaign, course]
  parent :admin_course, campaign, course
end

crumb :admin_campaigns do |project|
  link '模块列表', [:admin, project, :campaigns]
  parent :admin_project, project
end

crumb :new_admin_campaign do |project|
  link '新建模块', [:new, :admin, project, :campaign]
  parent :admin_campaigns, project
end

crumb :admin_campaign do |project, campaign|
  link '模块详情', [:admin, project, campaign]
  parent :admin_campaigns, project
end

crumb :edit_admin_campaign do |project, campaign|
  link '编辑模块', [:edit, :admin, project, campaign]
  parent :admin_campaign, project, campaign
end

crumb :admin_features do |project|
  link '花絮列表', [:admin, project, :features]
  if project
    parent :admin_project, project
  end
end

crumb :new_admin_feature do |project|
  link '新建花絮', [:new, :admin, project, :feature]
  parent :admin_features, project
end

crumb :admin_feature do |project, feature|
  link '花絮详情', [:admin, project, feature]
  parent :admin_features, project
end

crumb :edit_admin_feature do |project, feature|
  link '编辑模块', [:edit, :admin, project, feature]
  parent :admin_feature, project, feature
end

crumb :admin_schedules do |campaign|
  link '日程安排列表', [:admin, campaign, :schedules]
  parent :admin_campaign, campaign.project, campaign
end

crumb :new_admin_schedule do |campaign|
  link '新建日程安排', [:new, :admin, campaign, :schedule]
  parent :admin_schedules, campaign
end

crumb :admin_schedule do |campaign, schedule|
  link '日程安排详情', [:admin, campaign, schedule]
  parent :admin_schedules, campaign
end

crumb :edit_admin_schedule do |campaign, schedule|
  link '编辑日程安排', [:edit, :admin, campaign, schedule]
  parent :admin_schedule, campaign, schedule
end

crumb :admin_activities do |schedule|
  link '活动列表', [:admin, schedule, :activities]
  parent :admin_schedules, schedule.campaign
end

crumb :new_admin_activity do |schedule|
  link '新建活动', [:new, :admin, schedule, :activity]
  parent :admin_activities, schedule
end

crumb :admin_activity do |schedule, activity|
  link '活动详情', [:admin, schedule, activity]
  parent :admin_activities, schedule
end

crumb :edit_admin_activity do |schedule, activity|
  link '编辑活动', [:edit, :admin, schedule, activity]
  parent :admin_activity, schedule, activity
end

crumb :admin_lessons do |schedule|
  link '课程安排列表', [:admin, schedule, :lessons]
  parent :admin_schedules, schedule.campaign
end

crumb :new_admin_lesson do |schedule|
  link '新建课程安排', [:new, :admin, schedule, :lesson]
  parent :admin_lessons, schedule
end

crumb :admin_lesson do |schedule, lesson|
  link '课程安排详情', [:admin, schedule, lesson]
  parent :admin_lessons, schedule
end

crumb :edit_admin_lesson do |schedule, lesson|
  link '编辑课程安排', [:edit, :admin, schedule, lesson]
  parent :admin_lesson, schedule, lesson
end

crumb :admin_public_courses do
  link '公共课程列表', admin_public_courses_url
end

crumb :admin_public_course do |course|
  link '公共课程详情', admin_public_course_url(course)
  parent :admin_public_courses
end

crumb :admin_questionnaires do |course|
  link '试卷列表', course.public ? admin_public_course_questionnaires_url(course) : [:admin, course, :questionnaires]
  if course.public
    parent :admin_public_course, course
  else
    parent :admin_course, course.campaign, course
  end
end

crumb :new_admin_questionnaire do |course|
  link '新建试卷', [:new, :admin, course, :questionnaire]
  parent :admin_questionnaires, course
end

crumb :admin_questionnaire do |course, questionnaire|
  link '试卷详情', [:admin, course, questionnaire]
  parent :admin_questionnaires, course
end

crumb :edit_admin_questionnaire do |course, questionnaire|
  link '编辑试卷', [:edit, :admin, course, questionnaire]
  parent :admin_questionnaire, course, questionnaire
end

crumb :admin_opinionnaires do |course|
  link '评分列表', [:admin, course, :opinionnaires]
  parent :admin_course, course.campaign, course
end

crumb :new_admin_opinionnaire do |course|
  link '新建评分', [:new, :admin, course, :opinionnaire]
  parent :admin_opinionnaires, course
end

crumb :admin_opinionnaire do |course, opinionnaire|
  link '评分详情', [:admin, course, opinionnaire]
  parent :admin_opinionnaires, course
end

crumb :edit_admin_opinionnaire do |course, opinionnaire|
  link '编辑评分', [:edit, :admin, course, opinionnaire]
  parent :admin_opinionnaire, course, opinionnaire
end

crumb :admin_lucky_draws do |course|
  link '抽奖列表', [:admin, course, :lucky_draws]
  parent :admin_course, course.campaign, course
end

crumb :new_admin_lucky_draw do |course|
  link '新建抽奖', [:new, :admin, course, :lucky_draw]
  parent :admin_lucky_draws, course
end

crumb :admin_lucky_draw do |course, lucky_draw|
  link '抽奖详情', [:admin, course, lucky_draw]
  parent :admin_lucky_draws, course
end

crumb :edit_admin_lucky_draw do |course, lucky_draw|
  link '编辑抽奖', [:edit, :admin, course, lucky_draw]
  parent :admin_lucky_draws, course
end

crumb :admin_speech_draws do |course|
  link '演讲抽签列表', [:admin, course, :speech_draws]
  parent :admin_course, course.campaign, course
end

crumb :new_admin_speech_draw do |course|
  link '新建演讲抽签', [:new, :admin, course, :speech_draw]
  parent :admin_speech_draws, course
end

crumb :admin_speech_draw do |course, speech_draw|
  link '演讲抽签详情', [:admin, course, speech_draw]
  parent :admin_speech_draws, course
end

crumb :edit_admin_speech_draw do |course, speech_draw|
  link '编辑演讲抽签', [:edit, :admin, course, speech_draw]
  parent :admin_speech_draws, course
end

crumb :admin_debate_draws do |course|
  link '辩论抽签列表', [:admin, course, :debate_draws]
  parent :admin_course, course.campaign, course
end

crumb :new_admin_debate_draw do |course|
  link '新建辩论抽签', [:new, :admin, course, :debate_draw]
  parent :admin_debate_draws, course
end

crumb :admin_debate_draw do |course, debate_draw|
  link '辩论抽签详情', [:admin, course, debate_draw]
  parent :admin_debate_draws, course
end

crumb :edit_admin_debate_draw do |course, debate_draw|
  link '编辑辩论抽签', [:edit, :admin, course, debate_draw]
  parent :admin_debate_draws, course
end

crumb :admin_polls do |course|
  link '问卷列表', [:admin, course, :polls]
  if course.public
    parent :admin_public_course, course
  else
    parent :admin_course, course.campaign, course
  end
end

crumb :new_admin_poll do |course|
  link '新建问卷', [:new, :admin, course, :poll]
  parent :admin_polls, course
end

crumb :admin_poll do |course, poll|
  link '问卷详情', [:admin, course, poll]
  parent :admin_polls, course
end

crumb :edit_admin_poll do |course, poll|
  link '编辑问卷', [:edit, :admin, course, poll]
  parent :admin_poll, course, poll
end

crumb :admin_votes do |course|
  link '投票列表', [:admin, course, :votes]
  parent :admin_course, course.campaign, course
end

crumb :new_admin_vote do |course|
  link '新建投票', [:new, :admin, course, :vote]
  parent :admin_votes, course
end

crumb :admin_vote do |course, vote|
  link '投票详情', [:admin, course, vote]
  parent :admin_votes, course
end

crumb :edit_admin_vote do |course, vote|
  link '编辑投票', [:edit, :admin, course, vote]
  parent :admin_vote, course, vote
end

crumb :admin_banners do |project|
  link 'Banner列表', [:admin, project, :banners]
  if project
    parent :admin_project, project
  end
end

crumb :new_admin_banner do |project|
  link '新建Banner', [:new, :admin, project, :banner]
  parent :admin_banners, project
end

crumb :edit_admin_banner do |project, banner|
  link '编辑Banner', [:edit, :admin, project, banner]
  parent :admin_banners, project
end

crumb :admin_banner do |project, banner|
  link 'Banner详情', [project, banner]
  parent :admin_banners, project
end

crumb :admin_cells do |project|
  link '微信模块列表', [:admin, project, :cells]
  parent :admin_project, project
end

crumb :edit_admin_cell do |project, cell|
  link '编辑微信模块', [:edit, :admin, project, cell]
  parent :admin_cells, project
end

crumb :admin_menus do
  link '微信菜单列表', [:admin, :menus]
end

crumb :new_admin_menu do
  link '新建微信菜单', [:new, :admin, :menu]
  parent :admin_menus
end

crumb :edit_admin_menu do |menu|
  link '编辑微信菜单', [:edit, :admin, menu]
  parent :admin_menus
end

crumb :admin_menu do |menu|
  link '微信菜单详情', menu
  parent :admin_menus
end

crumb :admin_pages do
  link '静态页面列表', [:admin, :pages]
end

crumb :edit_admin_page do |page|
  link '编辑静态页面', [:edit, :admin, page]
  parent :admin_pages
end

crumb :admin_page do |page|
  link '静态页面详情', page
  parent :admin_pages
end

crumb :admin_event_reply do
  link '被添加自动回复'
end
