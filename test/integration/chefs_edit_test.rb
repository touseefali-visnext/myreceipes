require "test_helper"

class ChefsEditTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "Touseef", email: "touseef@example.com", password: "password", password_confirmation: "password")
    # @recipe = Recipe.create(name: "Vegetale saute", description: "Greate vegetable saute, add vegetable and oil", chef: @user)
  end

  test "reject an invalid edit signup" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template "chefs/edit"
    patch chef_path(@chef), params: { chef: { chefname: " ", email: "touseef@example.com" } }
    assert_template "chefs/edit"
    assert_select "h2.card-title"
    assert_select "div.card-body"
  end

  test "accept valid signup" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template "chefs/edit"
    patch chef_path(@chef), params: { chef: { chefname: "Touseef Ali", email: "touseef1@example.com" } }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "Touseef Ali", @chef.chefname
    assert_match "touseef1@example.com", @chef.email
  end
end
