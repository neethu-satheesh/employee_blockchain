# frozen_string_literal: true

module Api
  module V1
    class PostsController < Api::V1::ApiController
      respond_to :json

      def blockchain_data
        binding.pry
        post = Post.find_by(request_type: request_params[:post_type], identifier: identifier)
        (render_missing_post && return) if post.blank?
        if post.update_attributes(blockchain_response: blockchain_response_params)
          render json: post
        else
          render_error
        end
      end

      private

      def request_params
        params.require(:post).permit(:blockchain_response, :post_type, :email)
      end

      def blockchain_response_params
        params.require(:post).require(:blockchain_response)
      end

      def post_user
        User.find_by(email: request_params[:email])
      end

      def identifier
        case request_params[:post_type]
        when 'Create Employee', 'Retrieve Employee', 'Create Organization', 'Retrieve Organization'
          'email=' + request_params[:email]
        when 'Create Employee Experience', 'Retrieve Employee Experience'
          # needs requester's email also. This will not be in contract, but will be send to node server.
          EmployeeExperience::IDENTIFIER + [
                                             experience_response_params[:employee_email],
                                             experience_response_params[:organization_name],
                                             experience_response_params[:start_date]
                                           ].join(',')
        end

      end

      def experience_response_params
        blockchain_response_params.require(:data)
          .permit(
                  :employee_email,
                  :organization_name,
                  :start_date,
                  :end_date,
                  :is_currently_employed,
                  :designation,
                  :confirmed_person_name,
                  :confirmation_note
                )
      end

      def render_error
        render json: { errors: @post.errors.messages },
               status: 422
      end

      def render_missing_post
        render json: { errors: 'Post request is not found' },
               status: 422
      end

    end
  end
end
