require 'pry'

class BoatsController < ApplicationController

  def index
    @boats = Boat.all
    #binding.pry
  end

end
