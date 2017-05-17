class BoatClassification < ActiveRecord::Base
  belongs_to :boat
  belongs_to :classification

  def self.order_by_boat_id
  	self.order(:boat_id)
  end

end