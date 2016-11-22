class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :show, :destroy]

  def index
    @categories = Category.all
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
    
  end
  
  def edit
    
  end
  
  def update
    if @category.update(category_params)
      flash[:success] = "Category was successfully updated"
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
  
end