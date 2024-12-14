class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show 
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params)

    if @user.save
      # users' are logged in once they sign-up.
      @session[:user_id] = @user.id
      flash[:notice] = "Welcome to Alpha Blog #{@user.username}, you have successfully signed in"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your account information was successfully updated"
      redirect_to @user
    else
      render 'edit'
    end

    def destroy
      @user.destroy
      #if you delete the user directly then the session_user_id is set to user who has been deleted. So, to solve this issue you have to set the session_user_id to nil.
      # If an admin deletes another user's account, the session_user_id should not be set to nil because it would result in the session_user_id of the admin being incorrectly set to nil.
      # Ensure that if an admin deletes their own account, the session_user_id is set to nil at that time.
      session[:user_id] = nil if @user == current_user
      flash[:notice] = "Account and all associated articles successfully deleted."
      redirect_to articles_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  # Only logged-in users can edit or update their profiles.
  def require_user
    if (@current_user != @user || !@current_user.admin?)
      flash[:alert] = "You can only edit or delete your own account."
      redirect_to @user
    end
  end
end
