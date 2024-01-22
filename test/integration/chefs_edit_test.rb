require "test_helper"

class ChefsEditTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "Touseef", email: "touseef@example.com", password: "password", password_confirmation: "password")
    # @recipe = Recipe.create(name: "Vegetale saute", description: "Greate vegetable saute, add vegetable and oil", chef: @user)
    @chef2 = Chef.create!(chefname: "John", email: "john@example.com", password: "password", password_confirmation: "password")
    @admin_user = Chef.create!(chefname: "John1", email: "john1@example.com", password: "password", password_confirmation: "password", admin: true)
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

  test "accept valid edit" do
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

  test "accept edit attempt by admin user" do
    sign_in_as(@admin_user, "password")
    get edit_chef_path(@chef)
    assert_template "chefs/edit"
    patch chef_path(@chef), params: { chef: { chefname: "Touseef Ali 2", email: "touseef2@example.com" } }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "Touseef Ali 2", @chef.chefname
    assert_match "touseef2@example.com", @chef.email
  end

  test "redirect edit attempt by non-admin user" do
    sign_in_as(@chef2, "password")
    updated_name = "Joe"
    updated_email = "joe@example.com"
    patch chef_path(@chef), params: { chef: { chefname: updated_name, email: updated_email } }
    assert_redirected_to chefs_path
    assert_not flash.empty?
    @chef.reload
    assert_match "Touseef", @chef.chefname
    assert_match "touseef@example.com", @chef.email
  end
end
