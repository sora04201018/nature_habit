class Category < ApplicationRecord
  has_many :habit_categories, dependent: :destroy
  has_many :habits, through: :habit_categories

  # ransack検索許可
  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "id", "name", "updated_at" ]
  end
end
