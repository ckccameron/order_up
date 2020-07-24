require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
  end
  describe "relationships" do
    it {should belong_to :chef}
    it {should have_many :dish_ingredients}
    it {should have_many(:ingredients).through(:dish_ingredients)}
  end
  describe "methods" do
    it "#total_calories" do
      chef = Chef.create(name: "Mario Luigi")

      spaghetti = Dish.create(name: "Spaghetti", description: "molto delizioso", chef_id: chef.id)

      noodles = Ingredient.create(name: "Angel Hair Noodles", calories: 250)
      sauce = Ingredient.create(name: "Basilico Sauce", calories: 300)
      sausage = Ingredient.create(name: "Italian Sausage", calories: 400)

      DishIngredient.create(dish: spaghetti, ingredient: noodles)
      DishIngredient.create(dish: spaghetti, ingredient: sauce)
      DishIngredient.create(dish: spaghetti, ingredient: sausage)

      expect(spaghetti.total_calories).to eq(950)
    end
  end
end
