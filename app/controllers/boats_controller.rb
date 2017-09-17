class BoatController < ActionController::Base
  helper_method :params

  def index
    # filter the @boats list based on user input
    binding.pry
     if !params[:boat].blank?
       @boats = Boat.first_five
       binding.pry
      # if no filters are applied, show all posts
     else
      @boats = Boat.all
     end
   end
