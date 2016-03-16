class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
  	self.limit(5)
  end

  def self.dinghy
  	self.where("length < 20" )
  end

  def self.ship
  	self.where("length >= 20")
  end

  def self.last_three_alphabetically 
  	self.order('name DESC').limit(3).order('name ASC')
  end

  def self.without_a_captain
  	self.where('captain_id is NULL')
  end

  def self.sailboats
  	#sql= <<-SQL
  	#  SELECT boats.* FROM boats
    #  INNER JOIN boat_classifications ON boats.id = classifications.id
    #  INNER JOIN classifications ON boat_classifications.classification_id = classifications.id
    #SQL
  	self.joins(:classifications).where('classifications.name = "Sailboat"')
  end

  def self.with_three_classifications
  	 Boat.joins(:classifications).group("boats.name").having("count(*) = 3")
  end
  
end
