class Captain < ActiveRecord::Base
  has_many :boats


  def self.catamaran_operators
    all.includes(boats: :classifications).where(classifications:{name: 'Catamaran'} )
  end

  def self.sailors
    all.includes(boats: :classifications).where(classifications:{name: 'Sailboat'} ).uniq
  end

  def self.moatorboat_captains
    all.includes(boats: :classifications).where(classifications:{name: 'Motorboat'} ).uniq
  end

  def self.talented_seafarers
    where(id: self.sailors & self.moatorboat_captains)  
  end

  def self.non_sailors
    where.not(id: self.sailors)
  end

end
