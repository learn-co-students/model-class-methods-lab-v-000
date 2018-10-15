class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications
  
  
  def self.my_all
    self.all 
  end 
  
  def self.longest
    longest = Boat.all.first.length
    Boat.all.each do |b|
      if b.length > longest
        longest = b.length 
      end 
    end 
    self.includes(:boats).where(["boats.length IS ?", longest]).group("classifications.id")
  end 
  
  
  
  
  
  
  
end
