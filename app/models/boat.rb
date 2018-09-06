class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def first_five
    # returns the first five Boats
    
  end

  def dinghy
    # returns boats shorter than 20 feet
  end

  def ship
    # return boats 20 feet or longer
  end

  def last_three_alphabetically
    # returns last three boats in alphabetical order
  end

  def without_a_captain
    #returns boats wiout a captian
  end

  def sailboats
    # returns all boats that are sailboats
  end

  def with_three_classifications
    #return boats with three classifications
  end


end
