require "rails_helper"

RSpec.describe Post, type: :model do
  describe "バリデーションテスト" do
    context "有効な場合" do
      it "title, body, imageがある場合は有効" do
        post = build(:post)
        expect(post).to be_valid
      end
    end

    context "無効な場合" do
      it "titleが空の場合は無効" do
        post = build(:post, title: nil)
        expect(post).not_to be_valid
        expect(post.errors[:title]).to be_present
      end

      it "bodyが空の場合は無効" do
        post = build(:post, body: nil)
        expect(post).not_to be_valid
        expect(post.errors[:body]).to be_present
      end

      it "imageが空の場合は無効" do
        post = build(:post)
        post.image.detach
        expect(post).not_to be_valid
        expect(post.errors[:image]).to be_present
      end
    end
  end

  describe "アソシエーション" do
    it "postはuserに従属する" do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end

    it "postは複数のcommentsを持つ" do
      association = described_class.reflect_on_association(:comments)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end

    it "postは複数のlikesを持つ" do
      association = described_class.reflect_on_association(:likes)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end
  end
end