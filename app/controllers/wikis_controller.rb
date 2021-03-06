class WikisController < ApplicationController
  # after_action :verify_authorized
  def index
    # @wikis = Wiki.all
    @wikis = policy_scope(Wiki)
    # authorize @wikis
  end

  def show
    @wiki = Wiki.find(params[:id])
    # authorize @wiki
  end

  def new
    @user = current_user
    @wiki = Wiki.new
    # authorize @wiki
  end

  def create
    @user = current_user
    # binding.pry
    @wiki = @user.wikis.build(wiki_params)
    # authorize @wiki
    @wiki.user = @user

    if @wiki.private? && @wiki.save
      flash[:notice] = "Private wiki was saved successfully."
      redirect_to @wiki
    elsif @wiki.save
      flash[:notice] = "Public wiki was saved sucessfully"
      redirect_to @wiki
    else
      flash.now[:alert] = "Something went wrong; please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    # authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    # authorize @wiki
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
    # authorize @wiki
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
      if (current_user.standard?)
        params.require(:wiki).permit(:title, :body)
      else
        params.require(:wiki).permit(:title, :body, :private)
      end
  end

end
