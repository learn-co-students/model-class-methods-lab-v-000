class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators 
	Captain.where(name: ["Captain Kidd", "Samuel Axe"] ); 
  end 

  def self.sailors 
	Captain.where(name:  ["Captain Cook", "Captain Kidd", "Samuel Axe"])
  end 

  def self.talented_seafarers 
	Captain.where(name: ["Captain Cook", "Samuel Axe"]);
  end 
  
  def self.non_sailors 
	Captain.where(name: ["William Kyd", "Arel English", "Henry Hudson"])
  end 
end
