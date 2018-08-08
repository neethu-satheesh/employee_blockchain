# encoding: utf-8

require 'linkedin/authorization'
require 'response_handler'

module Linkedin
  class RetryableError < StandardError; end

  class Client
    include ResponseHandler

    attr_accessor :request

    def initialize(request)
      @request = request
    end

    def self.authorization
      new(Authorization.new).invoke
    end

    def invoke
      binding.pry
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
