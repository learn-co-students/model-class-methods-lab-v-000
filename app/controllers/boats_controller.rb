class BoatsController < ApplicationController
  def index
    @boats = Boat.all
  end

  def show 
    @boat = Boat.find_by(params[:id])
  end
end
