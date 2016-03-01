class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
  	select('*')
  end

  def self.classification
  	Classification.arel_table
  end

  def self.max_length
  	joins(:boats).maximum(:length)
  end

  def self.longest
  	joins(:boats).where(boats: {length: max_length})
  end

  def self.length_between
    joins(:boats).where(boats: {length: 20..30}).pluck("boats.name").uniq.sort
  end

  

end
