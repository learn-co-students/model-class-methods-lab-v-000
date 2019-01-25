class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: [:classifications]).where(:classifications => {:name => "Catamaran"})
  end

  def self.sailors
    joins(boats: [:classifications]).where(:classifications => {:name => "Sailboat"}).uniq
  end

  def self.motorboat_captains
    joins(boats: [:classifications]).where(:classifications => {:name => "Motorboat"}).uniq
  end

  def self.talented_seafarers
    where("id in (?)", (sailors.pluck(:id) & motorboat_captains.pluck(:id)))
  end

  def self.non_sailors
    where.not("id in (?)", self.sailors.pluck(:id))
  end
end
