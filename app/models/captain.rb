class Captain < ActiveRecord::Base
  has_many :boats


  def self.catamaran_operators
  end

  def self.sailors
    all.includes(:boats).where(boats: {classification: {name: 'Sailboat'}} )
  end

  def self.talented_seafarers
  end

  def non_sailors
  end

end
