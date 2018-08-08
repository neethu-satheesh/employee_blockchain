class Organization < ApplicationRecord

  def user
    User.find_by(email: email, profile_id: id)
  end
end
