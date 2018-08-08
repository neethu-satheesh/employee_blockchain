class EmployeeExperiencePolicy  < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def create?
    user.organization? && (record.organization_id == user.profile_id) && record.pending?
  end
end
