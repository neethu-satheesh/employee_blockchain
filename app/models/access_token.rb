# encoding: utf-8
class AccessToken
  EXPIRATION = (60 * 60 * 60).freeze # 60 days
  ISS = "dealshield.com #{Rails.env}".freeze
  SECRET = ENV.fetch('HMAC_SECRET')

  class << self
    def encode(user)
      payload = {
        data: user.id,
        iss: ISS,
        exp: Time.now.to_i + EXPIRATION
      }
      JWT.encode payload, SECRET, 'HS256'
    end
  end

  def initialize(token)
    token = token.split.last # Accepts both <hash> or `Bearer <token>` formats
    decoded_token = JWT.decode(token, SECRET, true, algorithm: 'HS256', iss: ISS, verify_iss: true)
    payload, = decoded_token
    @user_id = payload['data']
  rescue JWT::ImmatureSignature, JWT::DecodeError, JWT::ExpiredSignature => e
    Rails.logger.info e.inspect
    @user_id = nil
  end

  attr_reader :user_id

  def user
    return if @user_id.nil?
    @user ||= User.find(@user_id)
  end

  def logged_in?
    !user.nil?
  end
end
