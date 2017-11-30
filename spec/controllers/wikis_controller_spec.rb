require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let(:my_user) { create(:user, email: "test@blocipedia.com", password: "helloworld") }
  let(:my_wiki) { create(:wiki, user:my_user) }


  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns [my_wiki] to @wikis" do
      get :index
      expect(assigns(:wikis)).to eq([my_wiki])
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { id: my_wiki.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, params: { id: my_wiki.id }
      expect(response).to render_template :show
    end

    it "assigns wiki to @wiki" do
      get :show, params: { id: my_wiki.id }
      expect(assigns(:wiki)).to eq(my_wiki)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, params: { id: my_wiki.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new, params: { id: my_wiki.id }
      expect(response).to render_template :new
    end

    it "instantiates @wiki" do
      get :new, params: { id: my_wiki.id }
      expect(assigns(:wiki)).not_to be_nil
    end
  end

  describe "POST create" do
    before :each do
      sign_in my_user
    end
    it "increases the number of Wikis by 1" do
      expect{ post :create, params: { wiki: { title: RandomData.random_sentence, body: RandomData.random_paragraph, user: my_user } } }.to change(Wiki, :count).by(1)
    end
    it "assigns new wiki to @wiki" do
      post :create, params: { wiki: { title: my_wiki.title, body: my_wiki.body, user: my_user } }
      expect(assigns(:wiki)).to eq Wiki.last
    end
    it "redirects to the new Wiki" do
      post :create, params: { wiki: { title: my_wiki.title, body: my_wiki.body, user: my_user } }
      expect(response).to redirect_to Wiki.last
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: { id: my_wiki.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, params: { id: my_wiki.id }
      expect(response).to render_template :edit
    end

    it "asigns wiki to be updated to @wiki" do
      get :edit, params: { id: my_wiki.id }
      wiki_instance = assigns(:wiki)

      expect(wiki_instance.id).to eq my_wiki.id
      expect(wiki_instance.title).to eq my_wiki.title
      expect(wiki_instance.body).to eq my_wiki.body
      expect(wiki_instance.user).to eq my_wiki.user
    end
  end

  describe "PUT update" do
    it "updates wiki with expected attributes" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph

      put :update, params: { id: my_wiki.id, wiki: { title: new_title, body: new_body } }

      updated_wiki = assigns(:wiki)
      expect(updated_wiki.id).to eq my_wiki.id
      expect(updated_wiki.title).to eq new_title
      expect(updated_wiki.body).to eq new_body
      expect(updated_wiki.user).to eq my_wiki.user
    end

    it "redirects to the updated wiki" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph

      put :update, params: { id: my_wiki.id, wiki: { title: new_title, body: new_body } }
      expect(response).to redirect_to my_wiki
    end
  end

  describe "DELETE destroy" do
    it "deletes the Wiki entry" do
      delete :destroy, params: { id: my_wiki.id }
      count = Wiki.where({id: my_wiki.id}).size
      expect(count).to eq 0
    end

    it "redirects to the Wiki index" do
      delete :destroy, params: { id: my_wiki.id }
      expect(response).to redirect_to wikis_path
    end
  end

end
