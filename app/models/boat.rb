class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
  	first(5)
  end

  def self.dinghy 
  	where('length <?', '20')
  end

  def self.ship
  	where('length >=?', '20')
  end

  def self.longest_boat
    order(:length).last
  end

  def self.last_three_alphabetically
  	order(:name).last(3).reverse
  end

  def self.without_a_captain
  	where(captain: nil)
  end

  def self.sailboats
  	self.includes(:classifications).where(classifications:{name: 'Sailboat'})
  end

  def self.with_three_classifications
    self.joins(:classifications).group('boats.id').having('count(*) = 3')
  end

end 