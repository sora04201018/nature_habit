# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# 個々のバッジデータをseedで管理
Badge.destroy_all # 重複するバッジがないように最初に初期化

# バッジの種類
Badge.create!([
  { name: "駆け出しNature", description: "総達成回数3回", threshold: 3, icon: "Nature_budge01.jpeg" },
  { name: "中級Nature", description: "総達成回数10回", threshold: 10, icon: "Nature_budge02.jpeg" },
  { name: "上級Nature", description: "総達成回数15回", threshold: 15, icon: "Nature_budge03.jpeg" }
])

puts "Badges created!"
