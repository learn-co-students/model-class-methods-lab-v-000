class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five  #first five boats
    limit(5)
  end

  def self.dinghy #boats shorter than 20 ft
    where('length < 20')
  end

  def self.ship #20 ft or longer
    where('length > 20')
  end

  def self.last_three_alphabetically
    order('name desc').limit(3)
  end

  def self.without_a_captain #boats w/o captain
    where(captain_id: nil)
  end

  def self.sailboats #returns sailboats
    includes(:classifications).where(classifications: { name: "Sailboat" })
  end

  def self.with_three_classifications
    includes(:classifications).group("boats.id").having("COUNT(*) = 3")
  end

  def self.longest
    order(length: :desc).first
  end
  
end
