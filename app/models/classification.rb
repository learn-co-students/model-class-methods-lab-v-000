class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  # Where do I start?
  def self.my_all
    # I'm following the classification spec. First move is to make the my_all method
    #  self.my_all returns all classifications. I pryed and found out what the value of self is
    all
  end

  def self.longest
    # returns the classifications for the longest boat
    # What makes a boat the longest?
    # what methods does has_many give me?
    # Boat.where(Boat.maximum("length"))
    # Boat.where(Boat.maximum("length")).classifications - this didn't work
    # I'm not sure why it worked for find_by and not where
    Boat.find_by(length: Boat.maximum('length')).classifications
  end
end
