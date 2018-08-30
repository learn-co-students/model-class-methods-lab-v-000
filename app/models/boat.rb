
class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications
  
  def self.first_five
    all.limit(5)
  end
  
  def self.dinghy
    all.where("length < ?", 20)
  end
  
  def self.ship
    all.where("length > ?", 20)
  end
  
  def self.last_three_alphabetically
    all.order(name: :desc).limit(3)
  end
  
  def self.without_a_captain
    all.where(captain: nil)   
  end
  
  def self.sailboats
<<<<<<< HEAD
    all.includes(:classifications).where(classifications: {name: 'Sailboat'})
  end
  
  def self.with_three_classifications
    joins(:classifications).group("boats.id").having("count(classifications.id) = ?", 3)
=======
    includes(:classifications).where(classifications: {name: 'Sailboat'})
  end
  
  def self.with_three_classifications
binding.pry 
>>>>>>> b138aba06e8826058826fdb7a3f2bad26304eab0
  end
  
end


