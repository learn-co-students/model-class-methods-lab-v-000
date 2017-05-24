class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats
  def self.catamaran_operators
    self.includes(:classifications).where(classifications: {name: "Catamaran"}).group("captains.id")
  end
  def self.sailors
   self.includes(:classifications).where(classifications: {name: "Sailboat"}).group("captains.id")
  end
  def self.talented_seamen
   tal=[]
   self.all.each{|s|
     count1=0
     count2=0
     s.classifications.each{|c|
       if c.name=="Sailboat"
         count1+=1
       elsif c.name=="Motorboat"
         count2+=1
       end
     }
     if count1>0 and count2>0
       tal+=[s.name]
     end
   }
   self.where(name: tal)
  end
  def self.non_sailors
    tal=[]
   self.all.each{|s|
     count1=0
     s.classifications.each{|c|
       if c.name=="Sailboat"
         count1+=1
       end
     }
     if count1==0 
       tal+=[s.name]
     end
   }
   self.where(name: tal)
  end
end
