class BoatsController < ActionController::Base
  helper_method :params

  def index
    @boats = Boat.all
  end

  def new
    @boat = Boat.new
  end

  def create
    @boat = Boat.create
    @boat.save
    redirect_to boat_path(@boat)
  end

  def show
    @boat = Boat.find(params[:id])
  end
end
