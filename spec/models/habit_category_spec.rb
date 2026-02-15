require "rails_helper"

RSpec.describe HabitCategory, type: :model do
  describe "アソシエーション" do
    it "habit_categoryはhabitに従属する" do
      association = described_class.reflect_on_association(:habit)
      expect(association.macro).to eq(:belongs_to)
    end

    it "habit_categoryはcategoryに従属する" do
      association = described_class.reflect_on_association(:category)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end
