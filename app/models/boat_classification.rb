class BoatClassification < ActiveRecord::Base
  belongs_to :boat
  belongs_to :classification

  def self.sailboats
    where("name = ?", "Sailboat")
  end
end