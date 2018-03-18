class CaptainsController < ApplicationController
  def index
    if !params[:filter_by].blank?
      if params[:filter_by] == "Catamaran Operators"
        @captains = Captain.catamaran_operators
      end
    else
      @captains = Captain.all
    end
  end

end
