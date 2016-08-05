class ApplicationPolicy
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

  def index?
    true
  end

  def show?
    # scope.where(:id => record.id).exists?
    true
  end

  def create?
    true
  end

  def new?
    create?
  end

  def copy?
    create?
  end

  def preview?
    create?
  end

  def update?
    @user.admin? || record.user == user
  end

  def edit?
    update?
  end

  def destroy?
    @user.admin? || record.user == user
  end

  def sort?
    update?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  def draw_results?
    update?
  end

  def publish?
    create?
  end
end

