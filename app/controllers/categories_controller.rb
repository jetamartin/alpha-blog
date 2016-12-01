class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :show, :destroy]
  before_action :require_admin, except: [:index, :show]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "The #{@category.name} category was successfully created"
      redirect_to categories_path
    else
      render 'new'
    end
  end
  
  def show
    # Next two lines added to allow all articles with an assigned category to be shown
    # when view a category page
    @category = Category.find(params[:id])
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 2)
  end
  
  def edit
  
  end
  
  def update
    if @category.update(category_params)
      flash[:success] = "Category name was successfully updated"
      redirect_to category_path(@category)
    else
      render 'edit' 
    end
  end
  
  # Destroy should be limited to admin
  def destroy
    @category.destroy
    flash[:danger] = "Article was successfully deleted"
    redirect_to categories_path
  end
  
  private
  
  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
  
  def require_admin
    if !logged_in? || (logged_in? && !current_user.admin?)
      flash[:danger] = "Only Admins can perform that action"
      redirect_to categories_path
    end
  end
  
end