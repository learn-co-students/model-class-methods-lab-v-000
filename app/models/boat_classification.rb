class BoatClassification < ActiveRecord::Base
  belongs_to :boat
  belongs_to :classification

  def self.find_three
    BoatClassification.where("id > 0").group(:boat_id).having("count(*) = 3").pluck(:boat_id)
  end

end