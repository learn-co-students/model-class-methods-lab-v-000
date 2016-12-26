class BoatsController < ApplicationController

  def index
    @boats = Boat.all
  end

end
