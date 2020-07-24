require 'rails_helper'

RSpec.describe "dishes show page" do
  it "displays a list of ingredients and the chef name for a dish" do
    chef = Chef.create(name: "Mario Luigi")

    spaghetti = Dish.create(name: "Spaghetti", description: "molto delizioso", chef_id: chef.id)

    noodles = Ingredient.create(name: "Angel Hair Noodles", calories: 250)
    sauce = Ingredient.create(name: "Basilico Sauce", calories: 300)
    sausage = Ingredient.create(name: "Italian Sausage", calories: 400)

    DishIngredient.create(dish: spaghetti, ingredient: noodles)
    DishIngredient.create(dish: spaghetti, ingredient: sauce)
    DishIngredient.create(dish: spaghetti, ingredient: sausage)

    visit "dish/#{spaghetti.id}"
    expect(page).to have_content(noodles.name)
    expect(page).to have_content(sauce.name)
    expect(page).to have_content(sausage.name)
    expect(page).to have_content(chef.name)
  end
end
