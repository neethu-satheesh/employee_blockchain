# encoding: utf-8

require 'empex_blockchain/create_employee_request'
require 'empex_blockchain/retrieve_employee_request'
require 'empex_blockchain/create_organization_request'
require 'empex_blockchain/retrieve_organization_request'
require 'empex_blockchain/create_employee_experience_request'
require 'empex_blockchain/retrieve_employee_experience_request'
require 'response_handler'

module EmpexBlockchain
  class RetryableError < StandardError; end

  class Client
    include ResponseHandler

    attr_accessor :request

    def initialize(request)
      @request = request
    end

    def self.create_employee(employee)
      new(CreateEmployeeRequest.new(employee)).invoke
    end

    def self.retrieve_employee(employee)
      new(RetrieveEmployeeRequest.new(employee)).invoke
    end

    def self.create_organization(organization)
      new(CreateOrganizationRequest.new(organization)).invoke
    end

    def self.retrieve_organization(organization)
      new(RetrieveOrganizationRequest.new(organization)).invoke
    end

    def self.create_employee_experience(employee_experience)
      new(CreateEmployeeExperienceRequest.new(employee_experience)).invoke
    end

    def self.retrieve_employee_experience(employee_experience, employee)
      new(RetrieveEmployeeExperienceRequest.new(employee_experience, employee)).invoke
    end

    def invoke
      # binding.pry
      request.log_attempt(api_request.original_options[:body])
      api_request.run
      handle_response
    end

    def api_request
      @api_request ||= Typhoeus::Request.new(
        request.url,
        headers: headers,
        body: request_params,
        method: :post
      )
    end

    private

    def headers
      {
        'Content-Type' => 'application/json',
        # 'x-api-key' => ''
      }
    end

    def handle_response
      response_code, response_body = response_values(api_request.response)
      message = "Response Body : #{response_body}"
      request.create_post(response_body)
      if true #success?(response_code, response_body)
        request.log_success(message)
        is_processed = request.process_response(response_body)
        handle_error_response unless is_processed
      else
        handle_error_response(message)
      end
    end

    def request_params
      request.message.to_json
    end

    def handle_error_response(message = 'data was not found')
      request.log_failure(message)
      raise EmpexBlockchain::RetryableError, "EmpexBlockchain RetryableError - #{message}"
    end
  end
end
