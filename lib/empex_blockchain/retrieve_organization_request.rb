# encoding: utf-8

require 'request_handler'

module EmpexBlockchain
  class RetrieveOrganizationRequest
    include RequestHandler

    attr_accessor :organization

    def initialize(organization)
      @organization = organization
    end

    def url
      'http://localhost:8081/web3/getOrganization'
    end

    def message
      @message ||= {
        'organization': {
          'name': organization.name
        }
      }
    end

    def create_post(response_body)
      Post.create_record(
        user_id: user_id,
        request_type: 'Retrieve Organization',
        request: message,
        response: response_body,
        identifier: 'email=' + organization.email
      )
    end

    def log_attempt(request_params)

    end

    def log_failure(message = '', params = nil)

    end

    def log_success(message = '')

    end

    def process_response(response_body)
      collection = organization_response(response_body)
      # return false if collection.blank?
      true
    end

    def organization_response(response_body)
      JSON.parse(response_body)
    rescue
      log_failure('json parsing error', response_body)
      nil
    end

    private

    def user_id
      user = organization.user
      user.id if user
    end
  end
end
