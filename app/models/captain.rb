class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # returns all captains where boat classification.name = catamaran (id: 3), boat_classification with classification_id = 3
    includes(boats: [:classifications]).where("classifications.name = 'Catamaran'").references(:classifications)
  end

  def self.sailors
    includes(boats: [:classifications]).where("classifications.name = 'Sailboat'").references(:classifications).distinct
  end

  def self.talented_seamen
    seamen = sailors & motor_boaters
    where(id: seamen.map(&:id))
  end

  def self.motor_boaters
    includes(boats: [:classifications]).where("classifications.name = 'Motorboat'").references(:classifications).distinct
  end

  def self.non_sailors
    non_sailors = all - sailors
    where(id: non_sailors.map(&:id))
  end
end
