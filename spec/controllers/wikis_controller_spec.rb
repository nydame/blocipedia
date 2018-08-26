require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  # Reset
  User.delete_all
  Wiki.delete_all
  # Create wiki and users
  let!(:wiki_owner) { FactoryGirl.create(:user) }
  let!(:another_user) { FactoryGirl.create(:user) }

  before do
    wiki_owner.confirm
    another_user.confirm
    sign_in wiki_owner
  end

  let!(:wiki) {FactoryGirl.create(:wiki, user: wiki_owner)}

  wiki_params = {title: RandomData.random_sentence, body: RandomData.random_paragraph, private: false}

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "returns http redirect if user isn't logged in" do
      sign_out wiki_owner
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
    it "assigns [wiki] to @wikis" do
      Wiki.delete_all
      wiki = FactoryGirl.create(:wiki)
      get :index
      expect(assigns(:wikis)).to eq([wiki])
    end
    it "renders the #index view" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: {id: wiki.id}
      expect(response).to have_http_status(:success)
    end
    it "returns http redirect if user isn't logged in" do
      sign_out wiki_owner
      get :show, params: {id: wiki.id}
      expect(response).to redirect_to(new_user_session_path)
    end
    it "renders the #show view" do
      get :show, params: {id: wiki.id}
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    it "returns http redirect if user isn't logged in" do
      sign_out wiki_owner
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end
    it "renders the new view" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    it "increases Wiki.count by 1" do
      expect{post :create, params: {wiki: wiki_params}}.to change(Wiki, :count).by(1)
    end
    it "assigns the new wiki to @wiki" do
      post :create, params: {wiki: wiki_params}
      expect(assigns(:wiki)).to eq Wiki.last
    end
    it "redirects to the new wiki" do
      post :create, params: {wiki: wiki_params}
      expect(response).to redirect_to Wiki.last
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: {id: wiki.id}
      expect(response).to have_http_status(:success)
    end
    it "returns http redirect if user isn't logged in" do
      sign_out wiki_owner
      get :edit, params: {id: wiki.id}
      expect(response).to redirect_to(new_user_session_path)
    end
    it "renders the #edit view" do
      get :edit, params: {id: wiki.id}
      expect(response).to render_template(:edit)
    end
  end

  describe "PUT #update" do
    it "returns http redirect if user isn't owner of wiki" do
      sign_out wiki_owner
      sign_in another_user
      put :update, params: {id: wiki.id, wiki: {title: "Another title", body: wiki.body, private: wiki.private}}
      expect(response).to redirect_to(wiki_path(wiki.id))
    end
    it "updates wiki with expected attributes if user is owner" do
      put :update, params: {id: wiki.id, wiki: {title: "Another title", body: wiki.body, private: wiki.private}}
      updated_wiki = assigns(:wiki)
      updated_wiki.title = wiki.title
      updated_wiki.body = wiki.body
      updated_wiki.private = wiki.private
    end
    it "redirects to updated wiki if user is owner" do
      put :update, params: {id: wiki.id, wiki: {title: "Another title", body: wiki.body, private: wiki.private}}
      expect(response).to redirect_to(wiki_path(wiki.id))
    end
  end

  describe "DELETE #destroy" do
    it "stays on the wiki page if user is not owner" do
      sign_out wiki_owner
      sign_in another_user
      delete :destroy, params: {id: wiki.id}
      expect(response).to render_template(:show)
    end
    it "deletes the wiki if user is owner" do
      delete :destroy, params: {id: wiki.id}
      count = Wiki.where({id: wiki.id}).size
      expect(count).to eq 0
    end
    it "redirects to the Wikis page if user is owner" do
      delete :destroy, params: {id: wiki.id}
      expect(response).to render_template(:index)
    end
  end

end
