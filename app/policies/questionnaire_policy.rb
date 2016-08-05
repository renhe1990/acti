class QuestionnairePolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    raise Pundit::NotAuthorizedError, "必须登录后才能进行操作" unless user
    @user = user
    @record = record
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
      if user.admin?
        scope
      else
        scope.where(user_id: user.id)
      end
    end
  end

  def create?
    user.admin? || record.course.try(:user) == user
  end

  def new?
    create?
  end

  def update?
    create?
  end

  def edit?
    create?
  end

  def destroy?
    create?
  end

  def sort?
    update?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end
end

