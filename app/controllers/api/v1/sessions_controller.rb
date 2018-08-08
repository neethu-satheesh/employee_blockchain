# encoding: utf-8

module Api
  module V1
    class SessionsController < Api::V1::ApiController
      skip_before_action :authorize_user!
      respond_to :json

      def create
        auth = Authenticator.new(params[:username], params[:password])
        if auth.successful?
          auth.access_token = AccessToken.encode(auth.user)
          render json: { accessToken: auth.access_token }
        else
          render json: { error: auth.error }
        end
      end
    end
  end
end
