class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
      Captain.joins(boats:[boat_classifications: [:classification]]).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
      Captain.joins(boats:[boat_classifications: [:classification]]).group('captains.id').where(classifications: {name: "Sailboat"})
  end

  def self.talented_seamen
      Captain.joins(boats:[boat_classifications: [:classification]]).where(classifications: {name: ["Sailboat", "Motorboat"]}).group('captains.id').having('COUNT(DISTINCT classifications.id) = 2')
  end

  def self.non_sailors
      Captain.joins(boats:[boat_classifications: [:classification]]).group('captains.id').having('COUNT(case when classifications.name = "Sailboat" then 1 else null end) = 0')
  end
end
# AND classifications.name = "Motorboat"
#How hard is it to make a terminal that can consistantly accept keyboard input without being restarted every 20 minutes?
