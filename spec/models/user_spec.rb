require 'rails_helper'
# require 'spec_helper'

RSpec.describe User, type: :model do

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
end
