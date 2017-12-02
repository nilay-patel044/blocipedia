class WikisController < ApplicationController
  skip_before_action :authenticate_user!, except: [:index, :show]


  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
    # authorize @wiki
  end

  def create
    @wiki = current_user.wikis.new(wiki_params)
    # authorize @wiki

    if @wiki.save
      if @wiki.private
        flash[:notice] = "Your private wiki successfully created!"
      else
        flash[:notice] = "Wiki successfully created!"
      end
        redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving your Wiki. Please try again."
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
      flash[:notice] = "Wiki updated successfully!"
      redirect_to @wiki
    else
      puts "Error Updating Wiki\n\n#{@wiki.errors.full_messages}\n\n"
      flash.now[:alert] = "There was an error updating your Wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    # authorize @wiki
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" Wiki destroyed successfully!"
      redirect_to wikis_path
    else
      flash[:alert] = "There was an error deleting your Wiki. Please try again."
      render :show
    end
  end



  private
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
