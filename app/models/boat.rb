class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    # puts "get first five boats"
    Boat.limit(5)
  end

  def self.dinghy
    # puts "get dinghy?"
    Boat.where("length < ?", 20)
  end

  def self.ship
    # puts "get ship?"
    Boat.where("length >= ?", 20)
  end

  def self.last_three_alphabetically
    # puts "get last three alphabetically"
    boats = Boat.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    puts "get without a captain?"
    Boat.where("captain_id IS NULL")
  end

  def self.sailboats
    puts "get sailboats?"
  end

  def self.with_three_classifications
    puts "get with three classifications?"
  end

end

# rspec spec/models/boat_spec.rb
