class ArticlesController < ApplicationController
  # Eliminate code redundancy by setting article in a common method
  # before_action :set_article, only: [:edit, :update, :show, :destroy]
  # Enforces that you Must be logged to perform certain actions
  # before_action :require_user, except: [:index, :show ]
  # Enforces that you must be the author to perform certain actions
  # before_action :require_same_user, only: [ :edit, :update, :destroy]
   
  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article was successfully created"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit' 
    end
  end
  
  def destroy
    @article.destroy
    flash[:danger] = "Article was successfully deleted"    
    redirect_to articles_path
  end
  
  private
  def set_article
    @article = Article.find(params[:id])
  end
  def article_params
    params.require(:article).permit(:title, :description)
  end
  def require_same_user
    if current_user != @article.user
      flash[:danger] = "you can only edit or delete your articles"
      redirect_to root_path
    end
  end
end