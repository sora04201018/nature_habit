class Like < ApplicationRecord
  after_create :create_notification

  belongs_to :user
  belongs_to :likeable, polymorphic: true

  validates :user_id, uniqueness: { scope: [ :likeable_type, :likeable_id ] }

  private

  def create_notification
    # 自分自身がいいねした時は、通知を飛ばさず処理終了。
    return if likeable.user == user

    Notification.create!(
      visitor: user,  # 通知する人（いいねした人）
      visited: likeable.user,  # 通知される人（いいねされた人）
      notifiable: self,
      action: "like"
    )
  end
end
