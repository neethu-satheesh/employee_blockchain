class UsersController < ApplicationController

  def set_role
    @employee_role_id = Role.find_by(name: Role::EMPLOYEE).id
    @organization_role_id = Role.find_by(name: Role::ORGANIZATION).id
  end

  def save_role
    current_user.role_id = params[:user][:role_id] if current_user.role.blank?
    current_user.save
    redirect_to root_path
  end
end
