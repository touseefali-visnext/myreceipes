require "test_helper"

class RecipesEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = Chef.create!(chefname: "Touseef", email: "touseef@example.com", password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "Vegetale saute", description: "Greate vegetable saute, add vegetable and oil", chef: @user)
  end

  test "reject invalid recipe update" do
    get edit_recipe_path(@recipe)
    assert_template "recipes/edit"
    patch recipe_path(@recipe), params: { recipe: { name: " ", description: "some description" } }
    assert_template "recipes/edit"
    assert_select "h2.card-title"
    assert_select "div.card-body"
  end

  test "successfully edit recipe" do
    get edit_recipe_path(@recipe)
    assert_template "recipes/edit"
    updated_name = "Updated recipe name"
    updated_description = "updated recipe description"
    patch recipe_path(@recipe), params: { recipe: { name: updated_name, description: updated_description } }
    assert_redirected_to(@recipe)
    assert_not(flash.empty?)
    @recipe.reload
    assert_match(updated_name, @recipe.name)
    assert_match(updated_description, @recipe.description)
  end
end
