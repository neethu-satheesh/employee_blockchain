# frozen_string_literal: true

# Employee class

class Employee < ApplicationRecord

  has_many :employee_experiences

  def user
    User.find_by(email: email, profile_id: id)
  end
end
