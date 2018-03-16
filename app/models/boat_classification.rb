class BoatClassification < ActiveRecord::Base
  belongs_to :boat
  belongs_to :classification

  def self.first_five
    where("id < ?",6)
  end
end