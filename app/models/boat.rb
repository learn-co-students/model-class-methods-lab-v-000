class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
<<<<<<< HEAD
    Boat.all[0..4]
  end

 def self.dinghy
   where("length <= 20" )
 end

=======
    where(:boat_id.to_i <6)
  end
  
  def self.dinghy
    where(:length.to_i >= 20 )
  end
  
>>>>>>> 0dcf51c4776a0e74b99f139e62a230b380371e03
  def self.ship
    where("length > 20" )
  end

  def self.last_three_alphabetically
    Boat.all.sort {|a,b| b.name <=> a.name}.first(3)
  end

  def self.without_a_captain
    where(captain: nil)
  end

  def self.sailboats
  end

  def self.with_three_classifications
  end
  
  def self.longest_boat
  end

end
