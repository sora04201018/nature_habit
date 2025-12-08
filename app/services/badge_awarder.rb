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
      end
    end
  end
end
