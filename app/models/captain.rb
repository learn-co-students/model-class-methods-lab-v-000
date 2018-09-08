class Captain < ActiveRecord::Base
  has_many :boats

   def self.catamaran_operators
  #boats with captians where boat classification = catamarans
    #  returns all Captains of catamarns
      self.includes(boats: :classifications).where(:classifications => {:name => "Catamaran"})
   end

   def self.sailors
     #returns captians with sailboats
     self.includes(boats: :classifications).where(:classifications => {:name => "Sailboat"}).uniq

   end

   def self.motorboaters # we created this manually
    #returns captians with motorboats
    self.includes(boats: :classifications).where(:classifications => {:name => "Motorboat"}).uniq

  end

   def self.talented_seafarers
    # binding.pry
    #returns captains of motorboats and sailboats
    #searching where IDs is inside both sailers and motorbaters which are both arrays of ids
    self.where("id IN (?)", self.sailors.ids & self.motorboaters.ids)
   end

   def self.non_sailors
    # returns people who are not captains of sailboats
    self.where.not("id IN (?)", self.sailors.ids)
   end

   
end
