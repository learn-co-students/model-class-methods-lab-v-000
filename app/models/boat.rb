class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    puts "get first five boats"
    Boat.first(5)
  end

  def self.dinghy
    puts "get dinghy?"
    Boat.where("length < ?", 20)
  end

  def self.ship
    puts "get ship?"
    Boat.where("length >= ?", 20)
  end

  def self.last_three_alphabetically
    puts "get last three alphabetically"
    Boat.order(:name).first(3)
  end

  def self.without_a_captain
    puts "get without a captain?"
    Boat.where("captain_id = ?", nil)
  end

end

# rspec spec/models/boat_spec.rb
