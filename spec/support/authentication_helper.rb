module AuthenticationHelper
  def sign_in(user)
    controller.stub current_user: user
  end

  def admin_role
    Role.where(name: '管理员').first
  end

  def lecturer_role
    Role.where(name: '区域讲师').first
  end
end
