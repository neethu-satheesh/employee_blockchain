# frozen_string_literal: true

class EmployeeExperiencesController < ApplicationController
  def index
    @employee_experiences = EmployeeExperience.where(search_params)
                                   .page(params[:page]).per(10)
  end

  def new
    @employee_experience = EmployeeExperience.new
    @organization_list = Organization.all.order("name").pluck(:name, :id)
  end

  def create
    @employee_experience = EmployeeExperience.new(employee_experience_params)
    if @employee_experience.save
      flash[:notice] = 'EmployeeExperience created successfully'
      redirect_to employee_experience_path(@employee_experience)
    else
      flash[:alert] = @employee_experience.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @employee_experience = EmployeeExperience.where(id: params[:id]).first
    redirect_to employee_experiences_path if @employee_experience.blank?
  end

  def retrieve_from_blockchain
    @employee_experience = EmployeeExperience.where(id: params[:id]).first
    BlockchainJob::RetrieveEmployeeJob.perform_later(@employee_experience)
    redirect_to employee_experiences_path
  end

  def approval
    @employee_experience = EmployeeExperience.where(id: params[:id]).first
  end

  def rejection
    @employee_experience = EmployeeExperience.where(id: params[:id]).first
  end

  def approve
    @employee_experience = EmployeeExperience.where(id: params[:id]).first
    @employee_experience.set_review_attributes(employee_experience_params)
    @employee_experience.approve
    @employee_experience.save
    flash[:notice] = 'EmployeeExperience approved'
    redirect_to employee_experience_path(@employee_experience)
  end

  def reject
    @employee_experience = EmployeeExperience.where(id: params[:id]).first
    @employee_experience.reject
    @employee_experience.save
    flash[:notice] = 'EmployeeExperience rejected'
    redirect_to employee_experience_path(@employee_experience)
  end

  def blockchain_experience_search
    employee = Employee.where(email: params[:employee_experience][:email]).first

    employee.employee_experiences.each do |employee_experience|
      BlockchainJob::RetrieveEmployeeExperienceJob.perform_later(employee_experience, employee)
    end
    redirect_to root_path
  end


  private

  def employee_experience_params
    params.require(:employee_experience)
          .permit(:organization_id, :designation, :start_date,
            :is_currently_employed, :end_date, :request_reason,
            :confirmed_person_name, :confirmation_note)
          .merge(employee_id: current_user.profile_id)
  end

  def search_params
    if current_user.employee?
      { employee_id: current_user.profile_id }
    else
      { organization_id: current_user.profile_id }
    end
  end
end
