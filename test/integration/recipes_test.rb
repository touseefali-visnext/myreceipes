require "test_helper"

class RecipesTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = Chef.create!(chefname: "Touseef", email: "touseef@example.com")
    @recipe = Recipe.create(name: "Vegetale saute", description: "Greate vegetable saute, add vegetable and oil", chef: @user)
    @recipe2 = @user.recipes.build(name: "Chicken saute", description: "Great chicken dish")
    @recipe2.save
  end

  test "should get recipes index" do
    get recipes_path
    assert_response :success
  end

  test "should get recipes listing" do
    get recipes_path
    assert_template "recipes/index"
    assert_match @recipe.name, response.body
    assert_match @recipe2.name, response.body
  end
end
