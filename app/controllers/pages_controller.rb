class PagesController < ApplicationController
  def home
    # If the user is already logged in, the sign-up button should not be displayed on the home page.
    redirect_to articles_path if logged_in?
  end

  def about
  end
end
