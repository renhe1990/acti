module Admin::UsersHelper
  def build_user_filter_url(field, value)
    copy_params = params.slice(:role_id, :area_id, :grade_id, :gender, :status)
    copy_params[field] = value
    admin_users_url(copy_params)
  end

  def link_to_user_filter(name, field, value)
    selected = (params[field].presence == value.to_s)
    if selected
      name
    else
      link_to name, build_user_filter_url(field, value), class: "#{'selected' if selected}"
    end
  end

  def user_status_to_html(user)
    clazz, text = case user.status.to_sym
                  when :deleted
                    ['grey', '冻结']
                  when :incomplete
                    ['red', '缺少信息']
                  when :complete
                    ['green', '正常']
                  end
    content_tag :span, text, class: clazz
  end

  def role_filter_tag
    return if params[:role_id].blank?

    role = Role.find(params[:role_id])
    content_tag :span, class: 'label label-info' do
      concat "用户身份: #{role.name} "
      concat link_to content_tag(:span, nil, class: 'glyphicon glyphicon-remove'), build_user_filter_url(:role_id, nil)
    end
  end

  def area_filter_tag
    return if params[:area_id].blank?

    area = Area.find(params[:area_id])
    content_tag :span, class: 'label label-info' do
      concat "区域: #{area.name} "
      concat link_to content_tag(:span, nil, class: 'glyphicon glyphicon-remove'), build_user_filter_url(:area_id, nil)
    end
  end

  def grade_filter_tag
    return if params[:grade_id].blank?

    grade = Grade.find(params[:grade_id])
    content_tag :span, class: 'label label-info' do
      concat "职级: #{grade.name} "
      concat link_to content_tag(:span, nil, class: 'glyphicon glyphicon-remove'), build_user_filter_url(:grade_id, nil)
    end
  end

  def gender_filter_tag
    gender = params[:gender].presence
    return if gender.blank?

    gender = case params[:gender]
             when '1' then '女'
             when '0' then '男'
             end
    return if gender.blank?

    content_tag :span, class: 'label label-info' do
      concat "性别: #{gender} "
      concat link_to content_tag(:span, nil, class: 'glyphicon glyphicon-remove'), build_user_filter_url(:gender, nil)
    end
  end

  def status_filter_tag
    status = params[:status].presence
    return if status.blank?

    status = case params[:status].to_sym
             when :deleted then '冻结'
             when :incomplete then '缺少信息'
             when :complete then '正常'
             end
    return if status.blank?

    content_tag :span, class: 'label label-info' do
      concat "账号状态: #{status} "
      concat link_to content_tag(:span, nil, class: 'glyphicon glyphicon-remove'), build_user_filter_url(:status, nil)
    end
  end
end
