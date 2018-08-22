class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications
  
  def self.first_five
    self.all.limit(5)
  end
  
  def self.dinghy
    where('length < 20')
  end
  
  def self.ship
    where('length >= 20')
  end
  
  def self.last_three_alphabetically
    self.sort_alphabetically_by_name.limit(3)
  end
  
  def self.sort_alphabetically_by_name
    self.order(name: :desc)
  end
  
  def self.without_a_captain
    where(captain: nil)
  end
  
  def self.sailboats
    self.joins(:classifications).where(classifications: { name: "Sailboat" })
  end
  
  def self.with_three_classifications
    self.joins(:classifications).group("boats.id").having("COUNT(*) ==3")
  end
  
  def self.longest
    self.order(length: :desc).first
  end

end
