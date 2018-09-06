class Captain < ActiveRecord::Base
  has_many :boats

   def catamaron_operators
    #  returns all Captains of catamarns
   end

   def sailors
     #returns captians with sailboats
   end

   def talented_seafarers
    #returns captains of motorboats and sailboats
   end

   def non_sailors
    # returns people who are not captains of sailboats
   end

   def my_all
    #  returns all classifications
   end

   def longest returns the classifications for the longest boats
    # returns the classifications for the longest boat
   end

end
