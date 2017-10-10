class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    Classification.all.uniq
  end

  def self.longest
    boat = Boat.order('length DESC').limit(1)
    boat_classification = BoatClassification.where(boat_id: boat)

    all_ids = []
    boat_classification.to_a.each do |boat|
      all_ids << boat.classification_id
    end

    Classification.where(id: all_ids)
  end

end
