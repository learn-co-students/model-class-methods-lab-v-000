class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats 
  
  def self.catamaran_operators
    self.includes(:classifications).where(classifications:{name:"Catamaran"}).group("captains.id")
  end 
  
  def self.sailors
    self.includes(:classifications).where(classifications:{name:"Sailboat"}).group("captains.id")
  end 
  
  def self.talented_seafarers
    captains_array = []
    self.all.each do |c|
      a=[]
      c.classifications.each{|c| a<< c.name}
      if a.include?("Sailboat") && a.include?("Motorboat")
        captains_array<< c.name
      end
    end 
    self.where(name: captains_array)
  end 
  
  def self.non_sailors
    captains_array = []
    self.all.each do |c|
      a=[]
      c.classifications.each {|c| a<< c.name}
      if !a.include?("Sailboat")
        captains_array<< c.name 
      end 
    end 
    self.where(name: captains_array)
  end 
  
  
  
end
