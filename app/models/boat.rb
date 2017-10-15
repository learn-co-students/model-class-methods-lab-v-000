class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
  	limit(5)
  end

  def self.dinghy
  	where("length < ?", 20)
  end

  def self.ship 	
  	where("length >= ?", 20)
  end

  def self.last_three_alphabetically
  	reorder('name DESC').limit(3)
  end

  def self.without_a_captain
  	where("captain_id is NULL")
  end

  def self.sailboats	
  	includes(:classifications).where("classifications.name = 'Sailboat' ")
  end

  def self.with_three_classifications    

    includes(:classifications).group('boats.id').having('count(classification_id) = 3')
  end

  def self.longest_boat
    order(length: :desc).first
  end
  	
end
