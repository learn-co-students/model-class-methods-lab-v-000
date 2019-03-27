class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    limit(5)
  end

  def self.dinghy
    where("length <?", 20)
  end

  def self.ship
    where("length >=?", 20)
  end

  def self.last_three_alphabetically
    order("name desc").limit(3)
    # order(name: :desc).offset(3).last
    # find(:all, order: "id desc", limit: 5)
  end

  def self.without_a_captain
    where(captain: nil)
    # where("captain_id =?", nil)
  end

  def self.sailboats
    includes(:classifications).where(classifications: {name: 'Sailboat'})
    # where("classification =?", 'Sailboat')
    # where(classification: 'Sailboat')
    # select * boats from boats where classification is Sailboat
  end

  def self.with_three_classifications
    joins(:boat_classifications).group(:name).having('count(name) =?', 3)
    # joins(boat_classifications: :name).having('name sum =?', 3)
    # includes(:classifications).where(classifications: 'name sum =?', 3)
    # joins(boat_classifications: :name).where("name sum =?", 3)
    # includes(:classifications).where('classifications.count >=?', 3)
  end

end
