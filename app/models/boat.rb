class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.longest_id
    self.all.order(length: :desc).limit(1)[0].id
  end

  def self.x_captains(name)
    boat_id = Classification.where(name: name).limit(1)[0].id
    c = BoatClassification.arel_table
    self.joins(:boat_classifications).where(c[:classification_id].eq boat_id).pluck(:captain_id)
  end

  def self.first_five
    self.all.limit(5)
  end

  def self.dinghy
    self.where(self.arel_table[:length].lt 20)
  end

  def self.ship
    self.where(self.arel_table[:length].gteq 20)
  end

  def self.last_three_alphabetically
    self.all.order(name: :desc).limit(3)
  end

  def self.without_a_captain 
    self.where(self.arel_table[:captain_id].eq nil)
  end

  def self.sailboats
    sailboat_id = Classification.where(name: "Sailboat").limit(1)[0].id
    c = BoatClassification.arel_table
    self.joins(:boat_classifications).where(c[:classification_id].matches(sailboat_id))
  end

  def self.with_three_classifications
    ans = self.all.select {|b| b.classifications.length == 3}
    ans.map! {|b| b.id}
    self.where id: ans
  end

end
