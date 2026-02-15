require "rails_helper"

RSpec.describe Category, type: :model do
  describe "アソシエーション" do
    it "categoryhabit_categoriesを通して複数のhabitsを持つ" do
      category = described_class.reflect_on_association(:habits)
      expect(category.macro).to eq(:has_many)
      expect(category.options[:through]).to eq(:habit_categories)
    end
  end
end
