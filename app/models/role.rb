class Role < ApplicationRecord

  ROLE_NAMES = [
    ADMIN = 'admin'.freeze,
    EMPLOYEE = 'employee'.freeze,
    ORGANIZATION = 'organization'.freeze
  ].freeze
end
