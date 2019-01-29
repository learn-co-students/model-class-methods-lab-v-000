class CaptainsController < ApplicationController
  def show 
    @captain = Captain.find(params[:id])
  end
  
  def index 
    @captains = Captain.all 
  end 
end 