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
# バッジを安全に追加する（既存バッジは残す）
badges = [
  { name: "駆け出しNature", description: "総達成回数3回", threshold: 3, icon: "Nature_badge01.jpeg" },
  { name: "見習いNature", description: "総達成回数10回", threshold: 10, icon: "Nature_badge02.jpeg" },
  { name: "中級Nature", description: "総達成回数20回", threshold: 20, icon: "Nature_badge03.jpeg" },
  { name: "上級Nature", description: "総達成回数30回", threshold: 30, icon: "Nature_badge04.jpeg" },
  { name: "玄人Nature", description: "総達成回数40回", threshold: 40, icon: "Nature_badge05.jpeg" },
  { name: "達人Nature", description: "総達成回数50回", threshold: 50, icon: "Nature_badge06.jpeg" }
]

badges.each do |badge_attrs|
  # find_or_create_by を使うと、既存のバッジは残る
  Badge.find_or_create_by!(name: badge_attrs[:name]) do |badge|
    badge.description = badge_attrs[:description]
    badge.threshold = badge_attrs[:threshold]
    badge.icon = badge_attrs[:icon]
  end
end

puts "Badges seeded successfully!"


# カテゴリー初期データ
categories = [
  "散歩",
  "植物",
  "滝",
  "公園",
  "山",
  "海",
  "朝活",
  "瞑想",
  "リラックス"
]

categories.each do |name|
  Category.find_or_create_by!(name: name)
end

puts "Categories seeded successfully!"
