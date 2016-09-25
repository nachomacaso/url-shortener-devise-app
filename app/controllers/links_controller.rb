class LinksController < ApplicationController
  def index
    @links = current_user.links
  end

  def show
    @link = Link.find_by(id: params[:id], 
                         user_id: current_user.id)

    unless @link
      flash[:warning] = "Link not found"
      redirect_to '/links'
    end
  end

  def new
    @link = Link.new
    # need this line so that there are no validation errors on '/links/new'
  end

  def create
    @link = Link.new(slug: params[:slug],
                     target_url: params[:target_url],
                     user_id: current_user.id)

    @link.standardize_target_url!

    if @link.save
      flash[:success] = 'Successfully created link!'
      redirect_to '/links'
    else
      render 'new.html.erb'
    end
  end

  def edit
    @link = Link.find_by(id: params[:id],
                         user_id: current_user.id)
    
    unless @link
      flash[:warning] = "Link not found"
      redirect_to '/links'
    end
  end

  def update
    @link = Link.find_by(id: params[:id],
                         user_id: current_user.id)

    if @link && @link.update(slug: params[:slug], target_url: params[:target_url])
      @link.standardize_target_url!

      flash[:success] = "Successfully created link!"
      redirect_to '/links'
    else
      render 'edit.html.erb'
    end
  end

  def destroy
    @link = Link.find_by(id: params[:id],
                         user_id: current_user.id)

    if @link && @link.destroy
      flash[:success] = "Successfully deleted link!"
    else
      flash[:warning] = "Unsuccessfully deleted link!"
    end
    redirect_to '/links'
  end
end
