class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications
  
  def self.first_five
    self.limit(5).order("id ASC")
  end
  
  def self.dinghy
    self.where("length < ?", "20")
  end
  
  def self.ship
    self.where("length >= ?", "20")
  end
  
  def self.last_three_alphabetically
    self.limit(3).order("name DESC")
  end
  
  def self.without_a_captain
    self.where("captain_id IS NULL")
  end
  
  def self.sailboats
    ids = self.boats_of_type(["Sailboat"]).collect{|b| b.id}
    self.where({:id => ids})
  end
  
  def self.with_three_classifications
    ids = self.all.select{|b| b.classifications.size == 3}.collect{|b| b.id}
    self.where({:id => ids})
  end
  
  private
  
  def self.boats_of_type(arr)
    self.all.select{|b| ( b.classifications.collect{|c| c.name} & arr ).any?}
  end
end
