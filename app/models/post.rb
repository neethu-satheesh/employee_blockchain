# frozen_string_literal: true

# Post class

class Post < ApplicationRecord
  validates :request_type, :request, :user_id, presence: true
  belongs_to :user

  def self.create_record(values)
    post = Post.find_by(
                        user_id: values[:user_id],
                        request_type: values[:request_type],
                        identifier: values[:identifier]
                        )
    Post.create(
      user_id: values[:user_id],
      request_type: values[:request_type],
      request: values[:request],
      response: values[:response],
      identifier: values[:identifier]
    ) if post.blank?
  end
end
