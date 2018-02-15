class CaptiansController < ApplicationController
  def index
    @captains = Captain.all
  end

  def new
    @captain = Captain.new
  end

  def create
  end

  def edit
    @captain = Captain.find(boat_params[:id])
  end

  def update
    @captain = Captain.find(boat_params[:id])
  end

  def show
    @captain = Captain.find(boat_params[:id])
  end
end
