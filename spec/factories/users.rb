require 'random_data'

FactoryGirl.define do
  pw = RandomData.random_password

  factory :user do
    username RandomData.random_username
    sequence(:email){|n| "user#{n}@blocipedia.com"}
    password pw
    password_confirmation pw
    # role :standard
  end
  
end
