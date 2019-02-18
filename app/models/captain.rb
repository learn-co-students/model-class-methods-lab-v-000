class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
  	Captain.joins(boats: [:classifications]).where(classifications: {name: 'Catamaran'})
  end

  def self.sailors
  	joins(boats: [:classifications]).where(classifications: {name: 'Sailboat'}).uniq
  end

  def self.motorboaters
  	joins(boats: [:classifications]).where(classifications: {name: 'Motorboat'}).uniq
  end

  def self.talented_seafarers
  	where("id IN (?)", sailors.pluck(:id) & motorboaters.pluck(:id))
  end


  def self.non_sailors
  	where.not("id IN (?)", sailors.pluck(:id))
  end

end
