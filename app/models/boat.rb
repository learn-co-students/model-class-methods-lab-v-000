class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.longest
    order('length DESC').first
  end

  
  def self.first_five
    Boat.limit(5) 
  end

  def self.dinghy
    Boat.where("length < 20")
  end

  def self.ship
    Boat.where("length > 20")
  end

  def self.last_three_alphabetically
    Boat.order(:name => :desc).limit(3).all
  end

  def self.without_a_captain
    Boat.where(captain_id: [false, nil])
  end

  def self.sailboats
    Boat.joins(:boat_classifications => :classification).where(:classifications => {:name => "Sailboat"})
  end

  def self.with_three_classifications
    Boat.joins(:boat_classifications).group('boats.id').having('count(classification_id) = 3') 
  end
end



