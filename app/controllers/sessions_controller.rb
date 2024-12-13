class SessionsController < ApplicationController

  def new
  end
  
  def create
    # We use downcase here because the email was saved in the database in lowercase format.
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      #Now the user is logged in till future untill he logged out.
      session[:user_id] = user.id

      flash[:notice] = "Logged in Successfully"
      redirect_to user #redirect_to show page of logged_in user.

    else
      flash.now[:alert] = "There was something wrong with your login details"
      render 'new'
    end
  end

  def destroy
    #Logged out code is from backend only because i got difficulty to create the logged-out button.
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to root_path
  end
end
