class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    limit(5)
  end

  def self.dinghy
     having('length < 20').group(:id)
  end

  def self.ship
    having('length >= 20').group(:id)
  end

  def self.last_three_alphabetically
     order(name: :desc).limit(3)
  end

  def self.without_a_captain
    where(captain:nil)
  end

  def self.sailboats
    #includes :classifications table
    #referencing the :classifications
    includes(:classifications).where('classifications.name = ?','Sailboat').references(:classifications)
  end

  def self.with_three_classifications
    joins(:classifications).group("boats.id").having("COUNT(*) = 3")
  end

end
