require "rails_helper"

RSpec.describe Like, type: :model do
  
  describe "バリデーション" do
    context "有効な場合" do
      it "有効なlike" do
        like = build(:like)
        expect(like).to be_valid
      end
    end

    context "無効な場合" do
      it "1人のユーザーが同じ投稿に2回likeするのは無効" do
        user = create(:user)
        post = create(:post)

        create(:like, user: user, likeable: post)
        duplicate_like = build(:like, user: user, likeable: post)

        expect(duplicate_like).not_to be_valid
      end
    end
  end

  describe "アソシエーション" do
    it "likeはuserに従属する" do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end

    it "likeはlikeableに従属する" do
      association = described_class.reflect_on_association(:likeable)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:polymorphic]).to eq(true)
    end
  end

  describe "いいね通知" do
    let(:post_owner) { create(:user) }
    let(:other_user) {create(:user) }
    let(:post) {create(:post, user: post_owner) }

    it "他人の投稿にいいねすると通知が作られる" do
      expect{ create(:like, user: other_user, likeable: post) }.to change(Notification, :count).by(1)
    end

    it "自分の投稿にいいねした場合は通知は作られない" do
      expect { create(:like, user: post_owner, likeable: post) }.not_to change(Notification, :count)
    end
  end
end
