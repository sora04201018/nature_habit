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

  # ransack検索許可
  def self.ransackable_attributes(auth_object = nil)
    [ "title", "body" ] # 投稿はタイトル・本文で検索
  end

  # ransack関連
  def self.ransackable_associations(auth_object = nil)
    [ "user", "image_attachment", "image_blob", "comments", "likes" ]
  end
end
