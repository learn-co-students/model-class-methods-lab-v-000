class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # Desired SQL
    # select 'captains'.'*' from captains join boats on boats.captain_id = captains.id
    # join boat_classifications on boat_classifications.boat_id = boats.id
    # join classifications on boat_classifications.classification_id = classifications.id
    # where classifications.name = 'Catamrans'
    self.joins("join boats on boats.captain_id = captains.id").joins("join boat_classifications on boat_classifications.boat_id = boats.id").joins("join classifications on classifications.id = boat_classifications.classification_id").where("classifications.name = 'Catamaran'")
  end

  def self.sailors
    # Wow, that is weird stntax, I'd better get into it
    self.joins(boats: [boat_classifications: :classification]).where("classifications.name = 'Sailboat'").distinct
  end

  def self.talented_seamen
    motor_ids = self.joins(boats: [boat_classifications: :classification]).where("classifications.name = 'Motorboat'").pluck(:id)

    sailor_ids = self.sailors.pluck(:id)

    self.where("id IN (#{motor_ids.join(", ")}) AND id IN (#{sailor_ids.join(", ")})")

  end

  def self.non_sailors
    sailor_ids = self.sailors.pluck(:id)
    self.where("id not in (#{sailor_ids.join(", ")})")
  end

end
