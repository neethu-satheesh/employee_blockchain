# encoding: utf-8

require 'request_handler'

module EmpexBlockchain
  class CreateEmployeeRequest
    include RequestHandler

    attr_accessor :employee

    def initialize(employee)
      @employee = employee
    end

    def url
      'http://localhost:8081/web3/createEmployee'
    end

    def message
      @message ||= {
        'employee': {
          'name': employee.name,
          'email': employee.email,
          'phoneNumber': employee.phone_number,
          'careerStartDate': date_format(employee.career_start_date),
          'address': employee.address,
        }
      }
    end

    def create_post(response_body)
      Post.create_record(
        user_id: user_id,
        request_type: 'Create Employee',
        request: message,
        response: response_body,
        identifier: 'email=' + employee.email
      )
    end

    def log_attempt(request_params)

    end

    def log_failure(message = '', params = nil)

    end

    def log_success(message = '')

    end

    def process_response(response_body)
      collection = employee_response(response_body)
      # return false if collection.blank?
      true
    end

    def employee_response(response_body)
      JSON.parse(response_body)
    rescue
      log_failure('json parsing error', response_body)
      nil
    end

    private

    def user_id
      user = employee.user
      user.id if user
    end
  end
end
