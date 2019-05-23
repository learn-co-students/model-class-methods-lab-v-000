class BoatsController < ApplicationController
    def index
        @boats = Boat.all
    end
    
    def new 
        @boat = Boat.new
    end
    
    def show
        @boat = Boat.find(boat_params)
    end
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
    end
    
    def update
    end
    
    def boat_params
        params.require(:boat).permit(:name, :length)
end