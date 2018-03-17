class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
  	# includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  	joins(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
  	joins(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
  	# .distinct is like .uniq
  end

  def self.motoboaters
  	joins(boats: :classifications).where(classifications: {name: "Motorboat"}).distinct
  end

  def self.talented_seamen
  	where('id IN (?)', self.sailors.pluck(:id) & self.motoboaters.pluck(:id))
  end

  def self.non_sailors
  	where.not("id IN (?)", self.sailors.pluck(:id))
  end
end
