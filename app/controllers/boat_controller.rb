class BoatController < ApplicationController
  def index
    @boats = Boat.all
    if !params[:first_5]
      @boats = Boat.first_five
    end
  end
end