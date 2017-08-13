class BoatsController < ApplicationController

  def new
  end

  def create
    if new_boat.save
      redirect_to new_boat
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if boat.update_attributes(boat_params)
      redirect_to boat
    else
      render 'edit'
    end
  end

  def index
    @boats = Boat.all
  end

  private

  def boat
    @boat ||= Boat.find(params[:id])    
  end
  helper_method :boat

  def new_boat
    @new_boat ||= Boat.new(boat_params)
  end
  helper_method :new_boat

  def boat_params
    params.require(:boat).permit(:name, :length, :captain_id)
  end
end
