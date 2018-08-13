require 'rails_helper'

RSpec.describe Devise::Mailer do
  User.delete_all
  tester = FactoryGirl.create(:user)
  confirmation_email = Devise.mailer.deliveries.last
  
  it "sends a confirmation email to the correct email" do
    expect(tester.email).to eq confirmation_email.to[0]
  end

  it "sends a confirmation email with the correct body text" do
    expect(confirmation_email.body.to_s).to include('Welcome to Blocipedia!')
  end
end
