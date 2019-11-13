class ApplicationController < ActionController::Base

  before_action :require_user

  # this (vvv) makes the two methods accessible to all the views
  helper_method :current_user, :logged_in?
  
  def current_user
    # the pipes represent "Memorization". It will check if current user already 
    # exists and then skip the db query if it does.  
    @current_user ||= Student.find(session[:student_id]) if session[:student_id]
  end

  def logged_in?
    !!current_user # returns boolean dependng on current user
  end

  def require_user
    if !logged_in?
      flash[:notice] = "You must be logged in to perform this action"
      redirect_to login_path
    end
  end
  
end
