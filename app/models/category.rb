class Category < ApplicationRecord
  has_many :habit_categories, dependent: :destroy
  has_many :habits, through: :habit_categories
end
