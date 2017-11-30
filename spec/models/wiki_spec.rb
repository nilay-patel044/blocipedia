require 'rails_helper'

RSpec.describe Wiki, type: :model do

  let(:user) { create(:user, email: "test@blocipedia.com", password: "helloworld") }
  let(:wiki) { create(:wiki, title: "New Wiki Title", body: "New Wiki Body", private: false, user: user) }

  describe "attributes" do
    it "has title, body, and private attributes" do
      expect(wiki).to have_attributes(title: "New Wiki Title", body: "New Wiki Body", private: false, user: user)
    end
  end
end
