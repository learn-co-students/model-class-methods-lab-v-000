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

   def self.talented_seafarers
    binding.pry

    #returns captains of motorboats and sailboats
    self.includes(boats: :classifications).where(:classifications => {:name => "Sailboat" + "Motorboat"}).uniq

   end

   def self.non_sailors
    # returns people who are not captains of sailboats
   end

   def self.my_all
    #  returns all classifications
   end

   def self.longest_returns_the_classifications_for_the_longest_boats
    # returns the classifications for the longest boat
   end

end
