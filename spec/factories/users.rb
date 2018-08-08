FactoryGirl.define do
  factory :user do
    email 'neethu.satheesh@rubyians.com'
    password { SecureRandom.hex }
  end
end
