class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  
  # Enforces that you must be the author to perform certain actions
  before_action :require_same_user, only: [:edit, :update]
  
  
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the Alpha-Blog #{@user.username}. You are now logged in"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to articles_path
    else
      render 'edit'
    end
  end
  
  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def require_same_user
    if logged_in? 
      if current_user != @user
        flash[:danger] = "You can only edit your own account"
        redirect_to root_path
      end
    else
      flash[:danger] = "You must be logged in to edit/update account info"
      redirect_to root_path
    end
  end
end