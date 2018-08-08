# encoding: utf-8

module Api
  module V1
    class ApiController < ActionController::Base #ApplicationController
      # before_action :authorize_user!

      # skip_before_action :authenticate_user!

      def normalize_error_message(error_hash, mapping_hash)
        error_hash.transform_keys! do |key|
          key = mapping_hash[key] if mapping_hash[key].present?
          key
        end
      end

      private

      def authorize_user!
        token = request.headers['AUTHORIZATION']
        return render_unauthorized if token.nil?
        access_token = AccessToken.new token
        return render_unauthorized if access_token.user.nil?
        sign_in(:user, access_token.user, store: false)
      end

      def render_unauthorized
        render nothing: true, status: 401
      end
    end
  end
end
