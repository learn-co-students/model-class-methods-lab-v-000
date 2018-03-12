class BoatsController < ApplicationController

  def index
    @boats = Boat.all

    if !params[:boat].blank?
      @boats = Boat.first_five(params[:boat])
    end
  end

end
