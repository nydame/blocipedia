require 'rails_helper'

RSpec.describe WikisController, type: :controller do

  User.delete_all
  Wiki.delete_all
  # Create signed-in user
  wiki_owner = FactoryGirl.create(:user)
  before do
    wiki_owner.confirm
    sign_in wiki_owner
  end
  # Create wiki belonging to signed-in user
  wiki = FactoryGirl.create(:wiki, user: wiki_owner)

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "assigns [wiki] to @wikis" do
      get :index
      expect(assigns(:wikis)).to eq([wiki])
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

end
