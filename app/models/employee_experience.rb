class EmployeeExperience < ApplicationRecord
  include AASM

  belongs_to :employee
  belongs_to :organization

  extend EmployeeExperienceStateMachine

  IDENTIFIER = 'employee_email,org_email,start_date='.freeze

  def set_review_attributes(params)
    self.confirmed_date = Date.today
    self.confirmed_person_name = params[:confirmed_person_name]
    self.confirmation_note = params[:confirmation_note]
  end

  def identifier
    IDENTIFIER + [employee.email, organization.name, date_format(start_date)].join(',')
  end

  private

  def date_format(value)
    value&.in_time_zone('UTC')&.strftime('%Y-%m-%d')
  end

end
