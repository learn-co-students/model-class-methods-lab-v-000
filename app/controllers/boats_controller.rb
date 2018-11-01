class BoatsController < ApplicationController

  def new
    @boat = Boat.new
  end

  def create
    @boat = Boat.new(name: "name", length: "length")
    @boat.save
  end

  # def show
  #   @boats = Boat.all
  # end
end
