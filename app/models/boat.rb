class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications


#activerecord query methods - (5) Limit and Offset
  def self.first_five
    all.limit(5)
  end

  def self.dinghy
     where('length < 20')
  end

  def self.ship
    where('length >= 20')
  end


#activerecord query methods - (3)Ordering
  def self.last_three_alphabetically
    all.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    where(captain_id: nil)
  end

#activerecord query methods - 13.2 Specifying Conditions on
#eager associations
  def self.sailboats
    includes(:classifications).where(classifications: {name: 'Sailboat'})
  end

#Odin Project (Ruby on Rails Active Record Queries) Aggregations
  def self.with_three_classifications
    joins(:classifications).group("boat_id").having("COUNT(*)= 3")
  end

#this method not in the test, but used to build #Classifications method
#longest
  def self.longest
    order(length: :desc).first
  end

end
