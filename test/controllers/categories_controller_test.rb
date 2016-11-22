require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  def setup
    @category = Category.create(name: "sports")
  end
  
  test "should get categories index" do
    get :index
    assert_response :success
  end
  
  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should get show" do
    get(:show, {'id' => @category.id})
    assert_response :success
  end
  
  test "should get edit" do
    get(:edit, {id: @category.id})
    assert_response :success
  end
  
  
  ###################################################
  # Neither update or destroy were part of exercise
  ###################################################
  
  # Something wrong with update test
  # See http://stackoverflow.com/questions/6322183/how-to-test-the-update-method-in-rails for ideas
  
  test "should update category name" do
    put(:update, {:id => @category.id, :category => {:name => "sport1"}})
    assert_equal "sport1", @category.reload.name
    assert_redirected_to category_path(@category.id)
  end
  
  test "should delete category" do
    assert_difference('Category.count', -1) do
      delete(:destroy, {id: @category.id})
    end
    assert_redirected_to categories_path
  end
end