require 'rails_helper'

RSpec.describe "chefs show page" do
  before :each do
    @chef = Chef.create(name: "Mario Luigi")

    @spaghetti = Dish.create(name: "Spaghetti", description: "molto delizioso", chef_id: @chef.id)
    @ragu = Dish.create(name: "Mushroom Sausage Ragu", description: "gustare con vino rosso", chef_id: @chef.id)

    @noodles = Ingredient.create(name: "Angel Hair Noodles", calories: 250)
    @sauce = Ingredient.create(name: "Basilico Sauce", calories: 300)
    @sausage = Ingredient.create(name: "Italian Sausage", calories: 400)
    @morels = Ingredient.create(name: "Morel Mushrooms", calories: 100)
    @shiitakes = Ingredient.create(name: "Shiitake Mushrooms", calories: 15)

    DishIngredient.create(dish: @spaghetti, ingredient: @noodles)
    DishIngredient.create(dish: @spaghetti, ingredient: @sauce)
    DishIngredient.create(dish: @spaghetti, ingredient: @sausage)
    DishIngredient.create(dish: @ragu, ingredient: @sauce)
    DishIngredient.create(dish: @ragu, ingredient: @sausage)
    DishIngredient.create(dish: @ragu, ingredient: @morels)
    DishIngredient.create(dish: @ragu, ingredient: @shiitakes)
  end

  it "displays chef's name and link to list of ingredients they use for dishes they prepare" do
    visit "chef/#{@chef.id}"

    expect(page).to have_content(@chef.name)

    click_on "#{@chef.name}'s Ingredients"

    expect(current_path).to eq("chef/#{@chef.id}/ingredients")
    expect(page).to have_content(@noodles.name)
    expect(page).to have_content(@sauce.name)
    expect(page).to have_content(@sausage.name)
    expect(page).to have_content(@morels.name)
    expect(page).to have_content(@shiitakes.name)
  end
end
