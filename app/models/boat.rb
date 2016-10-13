class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications


  def self.first_five
    self.limit(5)
  end

  def self.dinghy
    self.where(:length => [0..19])
  end

  def self.ship
    self.where("length > ?", 20)
  end

  def self.last_three_alphabetically
    self.order("name desc").limit(3)
  end

  def self.without_a_captain
    self.where("captain_id is NULL")
  end

  def self.sailboats
    self.joins(:classifications).where(classifications: { :name=> "Sailboat"})
  end

  def self.with_three_classifications
    # self.joins(:classifications).count
    # self.joins(:classifications).sum("name.length ==? 3")
    self.joins(:classifications).group('boat.id').having( 'count( boat_classificationsboat.id ) ==3' )
    # self.joins( 'classifications_count == ?', 3 ).group(:name)

  end

end
