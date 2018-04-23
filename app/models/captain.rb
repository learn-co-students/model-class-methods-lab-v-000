class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
  	self.joins(:boats => :classifications).where("classifications.name = ?", "Catamaran")
  end

  def self.sailors
  	self.joins(:boats => :classifications).where("classifications.name = ?", "Sailboat").uniq
  end

  def self.motorboater
		self.joins(:boats => :classifications).where("classifications.name = ?", "Motorboat").uniq
  end

  def self.talented_seafarers
  	self.where("id IN (?)", sailors.pluck(:id) & motorboater.pluck(:id))
  	# one ampersand works with collections to combine them
  	# pluck returns an array of that specific attribute from the collection
  	# captains.pluck(:name) is the same as SELECT name FROM captains
  end

  def self.non_sailors
  	self.where("id NOT IN (?)", sailors.pluck(:id))
  end

end
