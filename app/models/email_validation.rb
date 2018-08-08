# frozen_string_literal: true

# validation for email

class EmailValidation
  include ActiveModel::Validations

  EMAIL_REGEX = /\A[\w.%+-]+@[\w.-]+\.[a-z]{2,4}\z/i

  attr_reader :email_id, :required
  alias required? required

  validates :email_id, presence: true, if: :required?
  validate :email_id_is_validated

  def self.valid?(emails)
    new(emails, required: true).valid?
  end

  def initialize(email_id, options = {})
    @email_id = Array(email_id)
    @required = options[:required]
  end

  private

  def email_id_is_validated
    errors.add(:base, 'Email is invalid') if
      email_id.present? && email_address_is_invalid?
  end

  def email_address_is_valid?
    email_id.all? { |email_address| EMAIL_REGEX.match?(email_address) }
  end

  def email_address_is_invalid?
    !email_address_is_valid?
  end
end
