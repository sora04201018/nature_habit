# バッジ付与Rakeタスク
namespace :badges do
  desc "Assign badges to all users based on their habit checks"
  task assign_all: :environment do
    User.find_each do |user|
      puts "Processing #{user.email}"
      BadgeAwarder.new(user).call
    end
    puts "Done!"
  end
end
