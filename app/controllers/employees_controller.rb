# frozen_string_literal: true

class EmployeesController < ApplicationController

  def index
    @employees = Employee.all.page(params[:page]).per(10)
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      current_user.update_attributes(profile_id: @employee.id)
      BlockchainJob::CreateEmployeeJob.perform_later(@employee)
      flash[:notice] = 'Employee created successfully'
      redirect_to employee_path(@employee)
    else
      flash[:alert] = @employee.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @employee = Employee.where(id: params[:id]).first
    redirect_to employees_path if @employee.blank?
  end

  def retrieve_from_blockchain
    @employee = Employee.where(id: params[:id]).first
    BlockchainJob::RetrieveEmployeeJob.perform_later(@employee)
    redirect_to employees_path
  end

  def edit
    @employee = Employee.where(id: params[:id]).first
    redirect_to employees_path if @employee.blank?
  end

  def blockchain_employee_search
    @employee = Employee.where(email: params[:employee][:email]).first
    BlockchainJob::RetrieveEmployeeJob.perform_later(@employee)
    redirect_to root_path
  end

  private

  def employee_params
    params.require(:employee)
          .permit(:name, :email, :phone_number, :career_start_date, :address)
  end
end
