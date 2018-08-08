# encoding: utf-8

require 'request_handler'

module EmpexBlockchain
  class CreateEmployeeExperienceRequest
    include RequestHandler

    attr_accessor :employee_experience

    def initialize(employee_experience)
      @employee_experience = employee_experience
    end

    def url
      'http://localhost:8081/web3/createEmployeeExperience'
    end

    def message
      @message ||= {
        'employeeExperience': {
          'employeeEmail': employee.email,
          'organizationName': employee_experience.organization.name,
          'startDate': date_format(employee_experience.start_date),
          'endDate': date_format(employee_experience.end_date) || '',
          'isCurrentlyEmployed': employee_experience.is_currently_employed,
          'designation': employee_experience.designation,
          'confirmedDate': date_format(employee_experience.confirmed_date),
          'confirmedPersonName': employee_experience.confirmed_person_name,
          'confirmationNote': employee_experience.confirmation_note || '',
        }
      }
    end

    def create_post(response_body)
      Post.create_record(
        user_id: user_id,
        request_type: 'Create Employee Experience',
        request: message,
        response: response_body,
        identifier: employee_experience.identifier
      )
    end

    def log_attempt(request_params)

    end

    def log_failure(message = '', params = nil)

    end

    def log_success(message = '')

    end

    def process_response(response_body)
      collection = employee_experience_response(response_body)
      # return false if collection.blank?
      true
    end

    def employee_experience_response(response_body)
      JSON.parse(response_body)
    rescue
      log_failure('json parsing error', response_body)
      nil
    end

    private

    def employee
      @employee ||= employee_experience.employee
    end

    def user_id
      user = employee.user
      user.id if user
    end
  end
end
