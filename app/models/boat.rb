class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    #Boat.find(:all, :order => "boat_id", :limit => 5)
    first(5)
  end

  def self.dinghy
    where( "length < ?", 20)
  end

  def self.ship
    where( "length > ?", 20)
  end

  def self.last_three_alphabetically
    #Boat.find(:all, :order => "name", :limit => 3)
    order(:name).last(3).reverse
  end

  def self.without_a_captain
    all.select { |boat| boat.captain_id == nil }
  end

  def self.sailboats
#    Boat.all.select { |boat| boat.classifications.name == 'Sailboat' }
    includes(:classifications).where('classifications.name = ?', 'Sailboat')
  end

  def self.with_three_classifications
    joins(:classifications).group("boats.id").having("COUNT(*) = 3")
  end

  def self.longest
    order('length DESC').first
  end

end
