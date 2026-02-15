require "rails_helper"

RSpec.describe Comment, type: :model do
  
  describe "バリデーション" do
    context "有効な場合" do
      it "bodyがあれば有効" do
        comment = build(:comment)
        expect(comment).to be_valid
      end
    end

    context "無効な場合" do
      it "bodyがない場合は無効" do
        comment = build(:comment, body: nil)
        expect(comment).not_to be_valid
        expect(comment.errors[:body]).to be_present
      end

      it "bodyが500文字を超えると無効" do
        comment = build(:comment, body: "あ" * 501)
        expect(comment).not_to be_valid
        expect(comment.errors[:body]).to be_present
      end
    end
  end

  describe "アソシエーション" do
    it "commentはuserに従属する" do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end

    it "commentはcommentableに従属している" do
      association = described_class.reflect_on_association(:commentable)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:polymorphic]).to eq(true)
    end
  end

  describe "コメント通知" do
    let(:post_owner) { create(:user) }
    let(:other_user) { create(:user) }
    let(:post) { create(:post, user: post_owner) }

    it "他人の投稿にコメントすると通知が作られる" do
      expect{ create(:comment, user: other_user, commentable: post) }.to change(Notification, :count).by(1)
    end

    it "自分の投稿に自分でコメント場合は通知は作られない" do
      expect{ create(:comment, user: post_owner, commentable: post) }.not_to change(Notification, :count)
    end
  end
end
