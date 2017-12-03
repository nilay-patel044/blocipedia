class CollaboratorsController < ApplicationController
  def new
    @collaborator = Collaborator.new
  end

  def create
    @collaborator_user = User.find_by_email(params[:collaborator])
    @wiki = Wiki.find(params[:wiki_id])

    if @wiki.collaborators.exists?(user_id: @collaborator_user.id)
      flash[:notice] = "#{@collaborator_user.email} is already a collaborator on this Wiki."
      redirect_to @wiki
    else
      @collaborator = Collaborator.new(user_id: @collaborator_user.id, wiki_id: @wiki.id)
      if @collaborator.save
        flash[:notice] = "#{@collaborator_user.email} added to Wiki Collaborators"
        redirect_to @wiki
      else
        flash[:alert] = "There was an error adding #{@collaborator_user.email} as a collaborator. Please try again."
        redirect_to @wiki
      end
    end
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    @collaborator_user = User.find(@collaborator.user_id)
    @wiki = Wiki.find(params[:wiki_id])

    if @collaborator.destroy
      flash[:notice] = "#{@collaborator_user.email} successfully removed from Collaborators."
      redirect_to @wiki
    else
      flash[:alert] = "There was an error deleting #{@collaborator_user.email} from Collaborators. Please try again."
      redirect_to @wiki
    end
  end
end
