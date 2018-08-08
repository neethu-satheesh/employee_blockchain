class EmployeePolicy  < ApplicationPolicy
  attr_reader :user, :employee

  def create?
    user.admin? || user.employee?
  end

  def update?
    create?
  end
end
