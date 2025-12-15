class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image # この記述でファイルアップロードを可能にする。postにimagesカラムを持たしたいのでpostに記述。
  has_many :comments, as: :commentable, dependent: :destroy # as: :commentableでpost.commentsを取得

  validates :title, presence: true
  validates :body, presence: true
  validates :image, presence: true
end
