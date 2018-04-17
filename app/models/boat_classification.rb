class BoatClassification < ActiveRecord::Base
  belongs_to :boat
  belongs_to :classification

  def self.find_by_number_of_classifications(number)
    h = self.group(:boat_id).count(:id).select{ |k, v| v == number }
    h.keys
  end
end
