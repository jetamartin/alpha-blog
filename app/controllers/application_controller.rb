class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  
  # Default is that methods defined in Application Controller can NOT be used in views.
  # So you Must explicitly tell Rails which methods can be used in views via helper_method 
  helper_method :current_user, :logged_in?
  
  def current_user
    # Check if user_id exist in session token if so lookup that user in DB via .find
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    # "!!" is Ruby idiom for converting value to boolean
    # So Returns true if user logged in else it returns false 
    !!current_user
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end
  
end
