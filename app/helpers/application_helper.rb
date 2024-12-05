module ApplicationHelper

  def gravator_for(user, options = {size: 80}) # If no size is passed at the time of calling then the default size is 80.
    email_address = user.email.downcase
    hash = Digest::SHA256.hexdigest(email_address)
    size = options[:size]
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"

    image_tag(gravatar_url, alt: user.username)
  end

  def current_user
    # Here memoization is used. 
    # Note: Here "session[:user_id]" is same as "sessions_controller", "session[:user_id]"
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end
end
