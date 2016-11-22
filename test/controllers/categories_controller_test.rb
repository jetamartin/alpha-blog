require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  def setup
    @category = Category.create(name: "sports")
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true) 
  end
  
  test "should get categories index" do
    get :index
    assert_response :success
  end
  
  test "should get new" do
    session[:user_id] = @user.id
    get :new
    assert_response :success
  end
  
  test "should get show" do
    get(:show, {'id' => @category.id})
    assert_response :success
  end
  
  test "should get edit" do
    session[:user_id] = @user.id
    get(:edit, {id: @category.id})
    assert_response :success
  end
  
  
  ###################################################
  # Neither update or destroy were part of exercise
  ###################################################
  
 
  test "should update category name" do
    session[:user_id] = @user.id
    put(:update, {:id => @category.id, :category => {:name => "sport1"}})
    assert_equal "sport1", @category.reload.name
    assert_redirected_to category_path(@category.id)
  end
  
  test "should delete category" do
    session[:user_id] = @user.id
    assert_difference('Category.count', -1) do
      delete(:destroy, {id: @category.id})
    end
    assert_redirected_to categories_path
  end
  
  # Note: setup doesn't log anyone in
  test "should redirect when admin not logged in " do
    assert_no_difference "Category.count" do 
      post :create, category: { name: "sports" }
    end
    assert_redirected_to categories_path
  end
  
end