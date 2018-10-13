class BoatsController < ApplicationController
    def index
    end
  
    def show
      @boat = Boat.find(params[:id])
    end
  
    def new
      @boat = Boat.new
    end
  
    def create
      @boat = Boat.new(boat_params)
  
      if @boat.save
        redirect_to @boat
      else
        render :new
      end
    end
  
    def edit
      @boat = Boat.find(params[:id])
    end
  
    def update
      @boat = Boat.find(params[:id])
  
      @boat.update(boat_params)
  
      if @boat.save
        redirect_to @boat
      else
        render :edit
      end
    end
  
    def destroy
      @boat = Boat.find(params[:id])
      @boat.destroy
      flash[:notice] = "Boat deleted."
      redirect_to boats_path
    end
  
    private
  
    def boat_params
      params.require(:boat).permit(:name, :length, :captain_id)
    end
  end
  