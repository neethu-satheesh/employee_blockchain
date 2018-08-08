# frozen_string_literal: true

class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.all.page(params[:page]).per(10)
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      current_user.update_attributes(profile_id: @organization.id)
      BlockchainJob::CreateOrganizationJob.perform_later(@organization)
      flash[:notice] = 'Organization created successfully'
      redirect_to organization_path(@organization)
    else
      flash[:alert] = @organization.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @organization = Organization.where(id: params[:id]).first
    redirect_to organizations_path if @organization.blank?
  end

  def retrieve_from_blockchain
    @organization = Organization.where(id: params[:id]).first
    BlockchainJob::RetrieveOrganizationJob.perform_later(@organization)
    redirect_to organizations_path
  end

  def edit
    @organization = Organization.where(id: params[:id]).first
    redirect_to organizations_path if @organization.blank?
  end

  private

  def organization_params
    params.require(:organization)
          .permit(:name, :registration_id, :email, :phone_number, :address)
  end
end
