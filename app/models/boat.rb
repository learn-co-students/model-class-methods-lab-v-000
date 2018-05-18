class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications
# arel_table[:attr].as("alias").to_sql
  def self.first_five
    limit(5)
  end

  def self.dinghy
    self.where("length < ?", 20)
  end

  def self.ship
    self.where("length >= ?", 20)
  end

  def self.last_three_alphabetically
    self.order("name desc").limit(3)
  end

  def self.without_a_captain
    self.where("captain" => nil)
  end

  def self.sailboats
    binding.pry
    self.where(name: (classifications: "Sailboat"))
     {|b| b.classifications.where("name" => "Sailboat")}
  end

  def self.with_three_classifications
  end
end
