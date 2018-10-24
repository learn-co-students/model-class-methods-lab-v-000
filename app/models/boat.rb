class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    limit(5)
  end

  def self.dinghy
    where(
      Boat.arel_table[:length].lt(20)
    )
  end

  def self.ship
    where(
      Boat.arel_table[:length].gteq(20)
    )
  end

  def self.last_three_alphabetically
    order(
      Boat.arel_table[:name].desc
    ).limit(3)
  end

  def self.without_a_captain

      where(captain_id: nil)

  end

  def self.sailboats
    joins(:classifications).where(
      "classifications.name" => "Sailboat"
    )
  end

  def self.with_three_classifications

    joins(:classifications).group(:boat_id).having(
      'count(*) == 3'
    )
  end

  def self.longest
    order('length DESC').first
  end

end
