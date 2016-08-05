class UserPolicy < ApplicationPolicy
  def new?
    @user.admin?
  end

  def create?
    new?
  end

  def import?
    new?
  end

  def delete?
    destroy?
  end

  def edit?
    @user.admin? || record.user == user
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  def restore?
    edit?
  end
end
