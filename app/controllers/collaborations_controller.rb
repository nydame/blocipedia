class CollaborationsController < ApplicationController
  after_action :verify_authorized

  def create
    wiki = Wiki.find(params[:collaboration][:wiki_id])
    user = User.find(params[:collaboration][:user_id])
    @collaboration = wiki.collaborations.build(collaboration_params)
    authorize @collaboration
    if ! wiki.private
      redirect_to wiki
      flash[:notice] do "Collaboration is only possible on private wikis." end
    elsif @collaboration.save
      #TODO send email to collaborator
      redirect_to wiki
      flash[:notice] do "#{user.username} is now a collaborator on #{wiki.title}." end
    else
      redirect_to wiki
      flash[:notice] do "Sorry, something went wrong." end
    end
  end

  def destroy
    @collaboration = Collaboration.find(params[:id])
    authorize @collaboration
    @wiki = Wiki.find(@collaboration.wiki_id)
    if @collaboration.destroy
      flash[:notice] do "The collaboration has been deleted." end
      redirect_to @wiki
    else
      flash[:notice] do "Sorry, something went wrong." end
      redirect_to @wiki
    end
  end

  private

  def collaboration_params
    params.require(:collaboration).permit(:user_id, :wiki_id)
  end
end
