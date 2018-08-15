class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    Boat.all[0..4]
  end

 def self.dinghy
   where("length <= 20" )
 end

  def self.ship
    where("length > 20" )
  end

  def self.last_three_alphabetically
    Boat.all.sort {|a,b| b.name <=> a.name}.first(3)
  end

  def self.without_a_captain
    all.where(captain_id:nil)
  end

  def self.sailboats
    all.includes(:classifications).where(classifications: {name: 'Sailboat'} )
  end

  def self.with_three_classifications
    includes(:classifications).group('boats.id').having('count(classification_id) = 3')
  end

  def self.longest_boat
    Boat.all.sort {|a,b| b.length <=> a.length}.first
  end

end
