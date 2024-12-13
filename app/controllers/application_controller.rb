class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Now the current_user method is available in both the controller as well as views.
  helper_method :current_user, :logged_in?

  def current_user
    # Here memoization is used. 
    # Note: Here "session[:user_id]" is same as "sessions_controller", "session[:user_id]"
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:alert] = "You must be logged in to perform that action."
      redirect_to login_path
    end
  end
end
