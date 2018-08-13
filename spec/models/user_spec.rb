require 'rails_helper'
# require 'spec_helper'

RSpec.describe User, type: :model do
  User.delete_all
  
  describe "attributes" do
    tester = FactoryGirl.build :user
    it "has a username and an email" do
      expect(tester).to have_attributes(username: tester.username, email: tester.email)
    end
  end

  describe "confirmation" do
    tester = FactoryGirl.build :user
    it "sends a confirmation email on sign-up" do
      expect {tester.save}.to change(Devise.mailer.deliveries, :count).by(1)
    end
  end

  describe "invalid user" do
    valid_user = FactoryGirl.create :user
    invalid_user_email = FactoryGirl.build :user, email: ""
    duplicate_user = FactoryGirl.build :user, email: valid_user.email
    it "is not able to sign up with invalid email" do
      numUsers = User.count
      invalid_user_email.save
      expect(User.count).to eq numUsers
    end

    it "is not able to sign up with duplicate email" do
      numUsers = User.count
      duplicate_user.save
      expect(User.count).to eq numUsers
    end
  end
end
