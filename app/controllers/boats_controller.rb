class BoatsController < ApplicationController
  def index
    @boats = Boat.all
  end

  def new
    @boat = Boat.new
  end

  def create
  end

  def edit
    @boat = Boat.find(boat_params[:id])
  end

  def update
    @boat = Boat.find(boat_params[:id])
  end

  def show
    @boat = Boat.find(boat_params[:id])
  end
end
