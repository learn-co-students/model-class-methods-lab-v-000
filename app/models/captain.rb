class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
  	self.classification_list('Catamaran').uniq
  end

  def self.sailors
  	self.classification_list('Sailboat').uniq
  end

  def self.motorboaters
  	self.classification_list('Motorboat').uniq
  end

  def self.talented_seamen
    self.where("name in (?)", self.sailors.pluck(:name) & self.motorboaters.pluck(:name))
  end

  def self.non_sailors
  	self.where("name not in (?)", self.sailors.pluck(:name))
  end

  private

  	def self.classification_list(boat_class)
  		self.all.includes(boats: :classifications).where('classifications.name = ?', boat_class)
  	end

	  def self.classification_join
	  	'INNER JOIN boats ON boats.captain_id = captains.id INNER JOIN boat_classifications ON boat_classifications.boat_id = boats.id INNER JOIN classifications ON boat_classifications.classification_id = classifications.id' 
	  end

end
