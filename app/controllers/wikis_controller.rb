class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @user = current_user
    @wiki = Wiki.new
  end

  def create
    @user = current_user
    @wiki = @user.wikis.build(wiki_params)
    @wiki.user = @user

    if @wiki.save
      flash[:notice] = "Wiki was saved successfully."
      redirect_to @wiki
    else
      flash.now[:alert] = "Something went wrong; please try again."
      render :new
    end
  end

  def edit
  end

  private

  def wiki_params
      params.require(:wiki).permit(:title, :body, :private?)
  end

end
