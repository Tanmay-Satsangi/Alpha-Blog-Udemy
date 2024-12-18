class ArticlesController < ApplicationController
  # The code is executed sequentially from top to bottom, so please carefully use the before_action.
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
  end

  def index 
    # @articles = Article.all
    @articles = Article.paginate(page: params[:page], per_page: 5)

  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    # Commented out below CORRECTED CODE because I am not able to pass the user_id fromt the front end.
    # For now, I am hardcoding the user_id to the first user's ID whenever a new article is created.
    # @article.user_id = current_user

    #Temporary hardcode the user-id so, we can create the articles from front end.
    @article.user_id = User.first.id
    
    if @article.save
      flash[:notice] = "Article was created successfully"
      redirect_to @article 
    else
      render 'new'
    end
  end

  def edit
  end

  def update
   if @article.update(article_params)
      flash[:notice] = "Article was updated successfully"
      redirect_to @article
   else
    render 'edit'
   end
  end

  def destroy
    @article.destroy

    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  # Only the creator of an article can edit, update, or delete it.
  def require_same_user
    if (@current_user != @user || !@current_user.admin?)
      flash[:alert] = "You can edit or delete your own articles."
      redirect_to @article
    end
  end
end
