class BoatsController < ApplicationController
  def index
    if !params[:filter_by].blank?
      if params[:filter_by] == "First 5"
        @boats = Boat.first_five
      elsif params[:filter_by] == "Dinghy"
        @boats = Boat.dinghy
      elsif params[:filter_by] == "Ship"
        @boats = Boat.ship
      elsif params[:filter_by] == "Last Three"
        @boats = Boat.last_three_alphabetically
      elsif params[:filter_by] == "No Captain"
        @boats = Boat.without_a_captain
      elsif params[:filter_by] == "Sailboats"
        @boats = Boat.sailboats
      elsif params[:filter_by] == "Three Classifications"
        @boats = Boat.with_three_classifications
      end
    else
      @boats = Boat.all
    end
  end

end
