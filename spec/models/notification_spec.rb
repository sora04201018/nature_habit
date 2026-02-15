require "rails_helper"

RSpec.describe Notification, type: :model do
  describe "アソシエーション" do
    it "notificationはvisitorに従属する" do
      association = described_class.reflect_on_association(:visitor)
      expect(association.macro).to eq(:belongs_to)
    end

    it "notificationはvisitedに従属する" do
      association = described_class.reflect_on_association(:visited)
      expect(association.macro).to eq(:belongs_to)
    end

    it "notificationはnotifiableに従属する" do
      association = described_class.reflect_on_association(:notifiable)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:polymorphic]).to eq(true)
    end
  end

  describe "scope :unread" do
    it "read_atがnil(未読)のものだけ取得する" do
      unread = create(:notification, read_at: nil)
      read = create(:notification, read_at: Time.current)

      expect(Notification.unread).to include(unread)
      expect(Notification.unread).not_to include(read)
    end
  end

  describe "valid_targetメソッド確認" do
    it "comment通知でcommetableが存在する場合はtrue" do
      notification = create(:notification)
      expect(notification.valid_target?).to be true
    end
  end

  describe "scope :valid" do
    it "通知先が存在する場合のみ、通知に反映" do
      valid_notification = create(:notification)
      invalid_notification = create(:notification)

      invalid_notification.notifiable.commentable.destroy

      expect(Notification.valid).to include(valid_notification)
      expect(Notification.valid).not_to include(invalid_notification)
    end
  end

  describe "redirect_path" do
    it "通知の種類に応じて遷移先に移動(commentの場合commentableの詳細へ遷移)" do
      notification = create(:notification)
      expect_path = Rails.application.routes.url_helpers.polymorphic_path(notification.notifiable.commentable)

      expect(notification.redirect_path).to eq(expect_path)
    end
  end
end
