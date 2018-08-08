# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    redirect_to set_role_user_path(current_user) if current_user.role.nil?
    @profile = current_user.employee || current_user.organization
  end

  def search_blockchain

  end
end
