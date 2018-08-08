class DashboardPolicy  < ApplicationPolicy
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def admin?
    user.admin?
  end

  def employee_create?
    admin? || user.employee?
  end

  def organization_create?
    admin? || user.organization?
  end
end
