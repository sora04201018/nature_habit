require "rails_helper"

RSpec.describe HabitCheck, type: :model do
  describe "バリデーションテスト" do
    it "checked_onがあれば有効" do
      habit_check = build(:habit_check)
      expect(habit_check).to be_valid
    end

    it "checked_onがなければ無効" do
      habit_check = build(:habit_check, checked_on: nil)
      expect(habit_check).not_to be_valid
      expect(habit_check.errors[:checked_on]).to be_present
    end

    it "checked_onはユーザーが1つの習慣につき1日1回だけチェックできる" do
      habit_check = create(:habit_check)
      duplicate = build(:habit_check, user: habit_check.user, habit: habit_check.habit, checked_on: habit_check.checked_on)
      expect(duplicate).not_to be_valid
    end
  end

  describe "アソシエーション" do
    it "habit_checkはuserに従属する" do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end

    it "habit_checkはhabitに従属する" do
      association = described_class.reflect_on_association(:habit)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end
