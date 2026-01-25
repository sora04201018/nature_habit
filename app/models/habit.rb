class Habit < ApplicationRecord
  belongs_to :user
  has_many :habit_checks, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy # as: :commentableでhabit.commentsを取得。
  has_many :likes, as: :likeable, dependent: :destroy # as: :likeableでhabit.likesを取得
  has_many :habit_categories, dependent: :destroy
  has_many :categories, through: :habit_categories

  attr_accessor :category_names # カテゴリーの仮属性

  validates :title, presence: true, length: { maximum: 100 }

  # frequency 頻度enum管理(毎日・週に3回・週に1回)
  enum frequency: { daily: 0, three_times_week: 1, once_a_week: 2 }

  # 公開されている習慣のみを取得する scope（ビューやコントローラで使う）。 publicly_visibleメソッドをシンボルで定義。
  scope :publicly_visible, -> { where(is_public: true) }

  # 特定の習慣を特定のユーザーが特定の日にチェックしたかを返すメソッド
  def checked_on?(user, date)
    habit_checks.exists?(user: user, checked_on: date)
  end

  # ユーザーが習慣を始めて１週間のうちに、どの日が達成(チェック)したのかを取り出すメソッド。pluckで配列で取り出す。
  def checks_for_week(user, week_start)
    habit_checks.where(user: user, checked_on: week_start..(week_start + 6.days)).pluck(:checked_on)
  end

  # 達成率を定義するメソッド(frequencyのenumによって達成目標数を分岐)
  def weekly_target
    case frequency

    when "daily" # 毎日→7回
      7
    when "three_times_week" # 週に3回→3回
      3
    when "once_a_week" # 週に1回→1回
      1
    else # デフォルト(毎日)
      7
    end
  end

  # 達成率計算メソッド(データ計算などはモデルに書く)
  def achievement_rate(user, week_start)
    achievement_count = habit_checks.where(user: user, checked_on: week_start..(week_start + 6.days)).count
    target = weekly_target

    # roundメソッドで小数点を四捨五入切り捨て
    ((achievement_count.to_f / target) * 100).round
  end

  # ransack検索許可
  def self.ransackable_attributes(auth_object = nil)
    [ "title" ] # 習慣はタイトル検索
  end

  # ransack関連
  def self.ransackable_associations(auth_object = nil)
    [ "categories" ]
  end
end
