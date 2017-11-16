class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
  	joins(boats: [:classifications]).where('classifications.name = ?', 'Catamaran')
  end

  def self.sailors
  	find_classifications("Sailboat")
  end

  def self.motorboat
  	find_classifications("Motorboat")
  end

  def self.find_classifications(klass)
  	joins(boats: [:classifications]).where('classifications.name = ?', "#{klass}").group('captains.name')
  end

  def self.talented_seamen
  	self.where("name IN (?) " , self.sailors.pluck(:name) & self.motorboat.pluck(:name))
  end

  def self.non_sailors
  	self.where("name NOT IN (?) " , self.sailors.pluck(:name))
  end
end
