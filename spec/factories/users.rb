FactoryGirl.define do

def random_password
  characters = ('a'..'z').to_a.concat(['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'])
  characters.shuffle!
  characters[0, rand(8..12)]
end

def random_username
  #
end
  pw = random_password

  factory :user do
    # username random_username
    sequence(:email){|n| "user#{n}@blocipedia.com"}
    password pw
    password_confirmation pw
  end
end
