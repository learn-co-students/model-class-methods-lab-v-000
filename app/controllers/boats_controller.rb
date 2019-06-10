class BoatsController < ApplicationController
  def index
    @boats = Boat.all
  end

  # def first_five
  #   @boats = Boat.all.first(5)
  #   render 'index'
  # end
  #
  # def dinghy
  #   User.where(length: < 20)
  #   render 'index'
  # end
  #
  # def ship
  #   User.where(length: => 20)
  #   render 'index'
  # end
end
