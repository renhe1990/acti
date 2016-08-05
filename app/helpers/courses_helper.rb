module CoursesHelper
  WIZARD_DESC = %w(课程基本信息 授课时间 课程试卷 课程问卷)

  def wizard_item(step, current_step)
    active = step == current_step
    class_name = active ? "wizard-item active" : "wizard-item"
    image_name = active ? "new-course-wizard-active.png" : "new-course-wizard.png"
    content_tag :div, class: class_name do
      concat image_tag(image_name)
      concat content_tag(:span, step)
      concat content_tag(:div, WIZARD_DESC[step - 1], class: 'desc')
    end
  end

  def build_public_course_filter_url(field, value)
    copy_params = params.slice(:genre, :hour)
    copy_params[field] = value
    public_courses_url(copy_params)
  end

  def link_to_public_course_filter(name, field, value)
    selected = (params[field].presence == value.to_s)
    if selected
      name
    else
      link_to name, build_public_course_filter_url(field, value), class: "#{'selected' if selected}"
    end
  end

  def survey_count_filter_tag
    return if params[:survey_count].blank?

    content_tag :span, class: 'label label-info' do
      concat "互动活动: #{ params[:survey_count].presence.to_i == 1 ? '有' : '无' } "
      concat link_to content_tag(:span, nil, class: 'glyphicon glyphicon-remove'), build_public_course_filter_url(:survey_count, nil)
    end
  end

  def genre_filter_tag
    return if params[:genre].blank?

    content_tag :span, class: 'label label-info' do
      concat "授课类型: #{params[:genre]} "
      concat link_to content_tag(:span, nil, class: 'glyphicon glyphicon-remove'), build_public_course_filter_url(:genre, nil)
    end
  end

  def hour_filter_tag
    return if params[:hour].blank?

    content_tag :span, class: 'label label-info' do
      concat "建议课时: #{params[:hour]} "
      concat link_to content_tag(:span, nil, class: 'glyphicon glyphicon-remove'), build_public_course_filter_url(:hour, nil)
    end
  end

  def course_date_range_label(course)
    starts_at, ends_at = course.starts_at, course.ends_at
    return '' if starts_at.nil? || ends_at.nil?

    if starts_at.nil?
      l(ends_at)
    elsif ends_at.nil?
      l(starts_at)
    else
      "#{ l(starts_at) } - #{ l(ends_at) }"
    end
  end
end
