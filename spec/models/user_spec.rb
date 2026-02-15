# モデルテスト（User） described_class == User
require "rails_helper"

RSpec.describe User, type: :model do
  describe "バリデーションチェック" do
    context "有効な場合" do
      it "name, email, passwordがあれば有効" do
        user = build(:user)
        expect(user).to be_valid
      end
    end

    context "無効な場合" do
      it "nameのみ空欄の場合は無効" do
        user = build(:user, name: nil)
        expect(user).not_to be_valid
        expect(user.errors[:name]).to be_present
      end

      it "emailのみ空欄の場合は無効" do
        user = build(:user, email: nil)
        expect(user).not_to be_valid
        expect(user.errors[:email]).to be_present
      end

      it "emailが重複した場合は無効" do
        create(:user, email: "text@example.com")
        user = build(:user, email: "text@example.com")
        expect(user).not_to be_valid
        expect(user.errors[:email]).to be_present
      end

      it "emailの形式が不正な場合は無効" do
        user = build(:user, email: "test-テスト-valid.com")
        expect(user).not_to be_valid
        expect(user.errors[:email]).to be_present
      end

      it "passwordのみ空欄の場合は無効" do
        user = build(:user, password: nil)
        expect(user).not_to be_valid
        expect(user.errors[:password]).to be_present
      end

      it "パスワードが６文字より少ない場合は無効" do
        user = build(:user, password: "pass")
        expect(user).not_to be_valid
        expect(user.errors[:password]).to be_present
      end
    end
  end


  describe "アソシエーション" do
    it "userは複数のhabitsを持つ" do
      association = described_class.reflect_on_association(:habits)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end

    it "userは複数のpostsを持つ" do
      association = described_class.reflect_on_association(:posts)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end

    it "userは複数のhabit_checksを持つ" do
      association = described_class.reflect_on_association(:habit_checks)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end

    it "userはuser_badgesを通して複数のbadgesを持つ" do
      association = described_class.reflect_on_association(:badges)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:through]).to eq(:user_badges)
    end

    it "userは複数のcommentsを持つ" do
      association = described_class.reflect_on_association(:comments)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end

    it "userは複数のlikesを持つ" do
      association = described_class.reflect_on_association(:likes)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end
  end
end
