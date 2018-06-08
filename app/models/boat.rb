require 'pry'
class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.all.limit(5)
  end

  def self.dinghy
    self.all.where("length < ?", 20)
  end

  def self.ship
    self.all.where("length >= ?", 20)
  end

  def self.last_three_alphabetically
    self.order(name: :desc).limit(3)
  end

  def without_a_captain
    #captain_id is null OR blank
    self.where(captain_id: [nil, ""])
  end

  def sailboats
    
  end

  def with_three_classifications
  end
end
