# habitモデルテスト
require "rails_helper"

RSpec.describe Habit, type: :model do
  describe "バリデーションテスト" do
    context "有効な場合" do
      it "title, frequency, is_publicがあれば有効" do
        habit = build(:habit)
        expect(habit).to be_valid
      end
    end

    context "無効な場合" do
      it "titleが空の場合は無効" do
        habit = build(:habit, title: nil)
        expect(habit).not_to be_valid
        expect(habit.errors[:title]).to be_present
      end

      it "titleが制限文字数(100文字)を超える場合は無効" do
        habit = build(:habit, title: "a" * 101)
        expect(habit).not_to be_valid
        expect(habit.errors[:title]).to be_present
      end
    end
  end


  describe "frequency enum設定" do
    it "frequencyでdailyが選択できる" do
      habit = build(:habit, frequency: :daily)
      expect(habit.frequency).to eq("daily")
    end
  end


  describe "publicly_visibleメソッドが有効" do
    it "公開済み習慣のみ取り出す" do
      public_habit = create(:habit, is_public: true)
      unpublic_habit = create(:habit, is_public: false)

      expect(Habit.publicly_visible).to include(public_habit)
      expect(Habit.publicly_visible).not_to include(unpublic_habit)
    end
  end


  describe "アソシエーション" do
    it "habitはuserに属している" do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end

    it "habitは複数のhabit_checksを持つ" do
      association = described_class.reflect_on_association(:habit_checks)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end

    it "habitはhabit_categoriesを通してcategoriesを複数持つ" do
      association = described_class.reflect_on_association(:categories)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:through]).to eq(:habit_categories)
    end
  end
end
