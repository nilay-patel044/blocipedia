require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it { is_expected.to have_many(:wikis) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }

  describe "user entry" do
    it "should contain proper email address" do
      expect(user.email).to eq('test@blocipedia.com')
    end

    it "should contain proper password" do
      expect(user.password).to eq('helloworld')
    end


    it "responds to role" do
      expect(user).to respond_to(:role)
    end

    it "responds to admin?" do
      expect(user).to respond_to(:admin?)
    end

    it "responds to member?" do
      expect(user).to respond_to(:member?)
    end

    it "should respond to premium?" do
      expect(user).to respond_to(:premium?)
    end
  end

  describe "roles" do
    it "is member by default" do
      expect(user.role).to eql("member")
    end

    context "member user" do
      it "returns true for #member?" do
        expect(user.member?).to be_truthy
      end

      it "returns false for #admin?" do
        expect(user.admin?).to be_falsey
      end

      it "returns false for #premium?" do
        expect(user.premium?).to be_falsey
      end
    end

    context "admin user" do
      before do
        user.admin!
      end

      it "returns false for #member?" do
        expect(user.member?).to be_falsey
      end

      it "returns true for #admin?" do
        expect(user.admin?).to be_truthy
      end

      it "returns false for #premium?" do
        expect(user.premium?).to be_falsey
      end
    end


    context "premium user" do
      it "returns false for #member?" do
        expect(user.member?).to be_falsey
      end

      it "returns false for #admin?" do
        expect(user.admin?).to be_falsey
      end

      it "returns true for #premium?" do
        expect(user.premium?).to be_truthy
      end
    end
  end
end
