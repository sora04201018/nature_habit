class Notification < ApplicationRecord
  belongs_to :visitor, class_name: "User", optional: true
  belongs_to :visited, class_name: "User"
  belongs_to :notifiable, polymorphic: true

  scope :unread, -> { where(read_at: nil) } # 通知が未読のデータを呼び出せるよう定義

  # 通知クリックで対象先へ遷移するメソッド（コメント・いいねは、習慣/投稿詳細、バッジはマイページへ遷移）。
  def redirect_path
    case action
    when "comment"
      Rails.application.routes.url_helpers.polymorphic_path(notifiable.commentable)
    when "like"
      Rails.application.routes.url_helpers.polymorphic_path(notifiable.likeable)
    when "badge"
      Rails.application.routes.url_helpers.mypage_path
    end
  end
end
