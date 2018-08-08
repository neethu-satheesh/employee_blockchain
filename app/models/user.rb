# frozen_string_literal: true

# User class

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role, optional: true

  validate :validate_email

  def admin?
    role&.name == Role::ADMIN
  end

  def employee?
    role&.name == Role::EMPLOYEE
  end

  def organization?
    role&.name == Role::ORGANIZATION
  end

  def employee
    @employee ||= Employee.find_by(id: profile_id) if employee? && profile_id.present?
  end

  def organization
    @organization ||= Organization.find_by(id: profile_id) if organization? && profile_id.present?
  end

  def entity_name
    if employee?
      employee.name if employee
    elsif organization?
      organization.name if organization
    end
  end

  private

  def validate_email
    is_valid = EmailValidation.new(email, required: true).valid?
    errors.add(:base, 'Email is invalid') unless is_valid
  end
end
