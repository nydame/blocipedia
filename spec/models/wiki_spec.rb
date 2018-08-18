require 'rails_helper'

RSpec.describe Wiki, type: :model do
  wiki_owner = FactoryGirl.create(:user)
  wiki = FactoryGirl.create(:wiki, user: wiki_owner)

  # it {is_expected.to belong_to(:user)}

  describe "attributes -" do
    it "has a title, body, privacy status and user" do
      expect(wiki).to have_attributes(title: wiki.title, body: wiki.body, private?: wiki.private?, user: wiki.user)
    end
  end
end
