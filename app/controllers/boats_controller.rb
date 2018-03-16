class BoatsController < ApplicationController
  helper_method :params

  def index
    @boats = Boat.all
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  #def song_params
    #params.require(:song).permit(:title, :artist_name)
  #end
end
