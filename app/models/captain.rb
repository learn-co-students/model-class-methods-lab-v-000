class Captain < ActiveRecord::Base
  has_many :boats

   def self.catamaron_operators
    #  returns all Captains of catamarns
   end

   def self.sailors
     #returns captians with sailboats
   end

   def self.talented_seafarers
    #returns captains of motorboats and sailboats
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
