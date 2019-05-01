class CaptainController < ApplicationController
  def index
    @captains = Captain.all
  end

  def show
    @captain = Captain.find(params[:id])
  end

  def new
    @captain = Captain.new
  end

  def create
    @captain = Captain.new(captain_params)
    if @captain.save
      redirect_to @captain
    else
      render :new
    end
  end

  def edit
    @captain = Captain.find(params[:id])
  end

  def update
    @captain = Captain.find(params[:id])
    if @captain.update(captain_params)
      redirect_to @captain
    else
      render :edit
    end
  end

  def destroy
    Captain.find(params[:id]).destroy
    redirect_to captains_url
  end

  private
  def captain_params
    params.require(:captain).permit(:name, :admiral)
  end
end
