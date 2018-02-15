class ClassificationsController < ApplicationController
  def index
    @classifications = Classification.all
  end

  def new
    @classification = Classification.new
  end

  def create
  end

  def edit
    @classification = Classification.find(boat_params[:id])
  end

  def update
    @classification = Classification.find(boat_params[:id])
  end

  def show
    @classification = Classification.find(boat_params[:id])
  end
end
