require 'rails_helper'
describe User do
  describe '#create' do
    it "is valid with a name, email, password, password_confirmation" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "is invalid without a name" do
      user = build(:user, name: "")
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end

    it "is invalid without an email" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "is inavalid without a password" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "is invalid without a password_confirmation" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とPasswordの入力が一致しません")
    end

    it "is invalid with a name that has more than 7 characters" do
      user = build(:user, name: "aaaaaaaa")
      user.valid?
      expect(user.errors[:name]).to include("は6文字以内で入力してください")
    end

    it "is invalid with a name that has less than 6 characters" do
      user = build(:user, name: "aaaa")
      user.valid?
      expect(user).to be_valid
    end

    it "is invalid with a dupulicate email" do
      user = create(:user)
      another_user = build(:user)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end

    it "is invalid with a password that has more than 6 characters" do
      user = build(:user, password: "00000000")
      user.valid?
      expect(user).to be_valid
    end

    it "is invalid with a password that has less than 5 characters" do
      user = build(:user, password: "0000")
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end


  end
end
