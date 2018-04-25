class Captain < ActiveRecord::Base
  has_many :boats
  
  def self.catamaran_operators
    ids = self.boats_of_type(["Catamaran"]).collect{|b| b.captain_id}
    self.where({:id => ids})
  end
  
  def self.sailors
    ids = self.boats_of_type(["Sailboat"]).collect{|b| b.captain_id}
    self.where({:id => ids})
  end
  
  def self.motorboat_operators
    ids = self.boats_of_type(["Motorboat"]).collect{|b| b.captain_id}
    self.where({:id => ids})
  end
  
  def self.talented_seafarers
    ids = (sailors & motorboat_operators).collect{|captain| captain.id}
    self.where({:id => ids})
  end
  
  def self.non_sailors
    ids = (self.all - sailors).collect{|captain| captain.id}
    self.where({:id => ids})
  end
  
  private
  
  def self.boats_of_type(arr)
    Boat.all.select{|b| ( b.classifications.collect{|c| c.name} & arr ).any?}
  end
end
