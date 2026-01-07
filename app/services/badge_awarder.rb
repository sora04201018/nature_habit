# バッジ付与のためのサービスクラス
class BadgeAwarder
  def initialize(user)
    @user = user
  end

  # ユーザーにまだ付与されていないバッジを付与する
  def call
    return unless @user  # ユーザーがいる場合のみ下記の処理を実行

    total = @user.total_habit_checks_count
    Badge.where("threshold <= ?", total).order(threshold: :asc).each do |badge|
      # そのバッジを持っていない場合のみ付与
      unless @user.badges.exists?(id: badge.id)
        @user.user_badges.create!(badge: badge, awarded_at: Time.current)

        # バッジ獲得のタイミングで通知付与
        Notification.create!(
          visitor: nil, # バッジ付与はvisitor(通知する人)がいないので、nil扱い。
          visited: @user,
          notifiable: badge,
          action: "badge"
        )

      end
    end
  end
end
