class User < ApplicationRecord
  has_many :habits, dependent: :destroy
  has_many :habit_checks, dependent: :destroy
  has_many :user_badges, dependent: :destroy
  has_many :badges, through: :user_badges
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :notifications, foreign_key: :visited_id, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2 line] # SNS認証（Google・LINE）

  has_one_attached :avatar # プロフィール画像

  validates :name, presence: true

  # プロフィール画像最適化
  def avatar_variant(size = 120)
    avatar.variant(resize_to_fill: [ size, size ], format: :webp)
  end

  # トータルの達成回数を集計（バッジ付与のため）
  def total_habit_checks_count
    habit_checks.count
  end

  # OmniAuth からユーザーを探す / 作る(既存ユーザーとの紐付け)
  def self.from_omniauth(auth)
    # 既にproviderとuidがあるかチェック(2回目以降SNSログイン)
    user = User.find_by(provider: auth.provider, uid: auth.uid)
    return user if user

    # 続いてSNSログインのメールアドレスが既に存在するか(存在する場合、SNS認証と既存ユーザーはメールアドレスが同じなので同じ人)
    user = User.find_by(email: auth.info.email)

    if user
      user.update(provider: auth.provider, uid: auth.uid)
      return user
    end

    # SNS認証で完全な新規作成
    User.create!(
      email: auth.info.email.presence || "#{auth.uid}@#{auth.provider}.example.com", # LINEの場合、メールバリデーションで引っ掛かってしまうため、一意のダミーを入れる。
      name: auth.info.name.presence || "#{auth.provider.capitalize}ユーザー",
      password: Devise.friendly_token[0, 20],
      provider: auth.provider,
      uid: auth.uid
    )
  end
end
