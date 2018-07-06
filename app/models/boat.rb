class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    select(:name).limit(5)
  end

  def self.dinghy
    select(:name).where('length < 20')
  end

  def self.ship
    select(:name).where('length > 19')
  end

  def self.last_three_alphabetically
    select(:name).order('name desc').limit(3)
  end

  def self.without_a_captain
    select(:name).where('captain_id is NULL')
  end

  def self.sailboats
    sailboat_class = Classification.find_by(:name => "Sailboat")
    Boat.joins(:classifications).where('classification_id = ?', sailboat_class.id)
  end

  def self.with_three_classifications
    Boat.joins(:classifications).group('boat_id').having("count(classification_id) = ?", 3)
  end

end
