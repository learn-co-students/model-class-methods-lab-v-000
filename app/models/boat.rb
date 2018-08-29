class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.all.limit(5)
  end

  def self.dinghy
    where("length < 20")
  end

  def self.ship
    where("length >= 20")
  end

  def self.last_three_alphabetically
    self.all.order("name DESC").limit(3)
  end

  def self.without_a_captain
    where(captain_id: nil)
  end

  def self.sailboats
    # Client.all :joins => :orders, :conditions => {:orders => {:created_at => time_range}}
    sailboatid= Classification.find_by(name: "Sailboat").id
    self.all.joins(:boat_classifications).where(:boat_classifications=>{:classification_id => sailboatid})
  end

  def self.with_three_classifications
    self.all.joins(:classifications).group("boat_id").having("Count(*) = 3")
  end

  def self.catamarans
    joins(:classifications).where(classifications: {name: "Catamaran"})
  end

  def self.motorboats
    joins(:classifications).where(classifications: {name: "Motorboat"})
  end

  def self.longest
    self.maximum("length")
  end
end
