class BoatClassification < ActiveRecord::Base
  belongs_to :boat
  belongs_to :classification

  def self.find_by_number_of_classifications(number)
  	hash_by_number = group(:boat_id).count(:id).select{|k,v| v == number}
  	hash_by_number.keys
  end
end