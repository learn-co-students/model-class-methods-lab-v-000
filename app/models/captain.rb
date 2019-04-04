class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
  	joins(boats: :classifications).merge(Classification.where(name: 'Catamaran'))
  end

  def self.sailors 
  	joins(boats: :classifications).merge(Classification.where(name: 'Sailboat')).distinct
  end

  def self.motorboats
  	joins(boats: :classifications).merge(Classification.where(name: 'Motorboat')).distinct
  end

  def self.talented_seafarers
  	seafarers = self.motorboats & self.sailors
  	seafarers.uniq
  end

  def self.non_sailors
  	where.not({id: self.sailors.pluck(:id)})
  end

end