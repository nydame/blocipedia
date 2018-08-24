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
    # binding.pry
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
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)

    if @wiki.save
      flash[:notice] = "Wiki was updated successfully."
      redirect_to @wiki
    else
      flash.now[:alert] = "Something went wrong; please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    if @wiki.user == current_user && @wiki.destroy
        flash[:notice] = "Wiki '#{@wiki.title}' was deleted."
        render :index
    else
      flash.now[:alert] = "The wiki could not be deleted. Make sure you have the permission to do so."
      render :show
    end
  end

  private

  def wiki_params
      params.require(:wiki).permit(:title, :body, :private)
  end

end
