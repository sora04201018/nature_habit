class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image # この記述でファイルアップロードを可能にする。postにimagesカラムを持たしたいのでpostに記述。
  has_many :comments, as: :commentable, dependent: :destroy # as: :commentableでpost.commentsを取得
  has_many :likes, as: :likeable, dependent: :destroy # as: :likeableでpost.commentsを取得

  validates :title, presence: true
  validates :body, presence: true
  validates :image, presence: true

  # minimagick画像最適化メソッド
  def display_image
    image.variant(resize_to_limit: [ 800, 800 ], format: :webp) # 画像サイズを縦横800pxにし、拡張子をwebp化
  end
end
