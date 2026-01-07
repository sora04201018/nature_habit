class Comment < ApplicationRecord
  after_create :create_notification

  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :body, presence: true, length: { maximum: 500 } # 500文字まで

  private

  def create_notification
    # 自分自身がコメントし場合は通知を飛ばさない（そこで処理終了）
    return if commentable.user == user

    Notification.create!(
      visitor: user,  # 通知する人（コメントした人）
      visited: commentable.user,  # 通知を受ける人（コメントされた人）
      notifiable: self,
      action: "comment"
    )
  end
end
