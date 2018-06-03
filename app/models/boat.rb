class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    puts "get first five boats"
    Boat.where("id < ?", 6)
    Boat.all.each do |boat|
      puts "Boat = name: #{boat.name} || length: #{boat.length} || cap: #{boat.captain_id}"
      if boat.captain_id is nil
        puts "captain id is nil"
      end
    end

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
    puts "get last three alphabetically"
    Boat.order(:name).limit(3)
  end

  def self.without_a_captain
    puts "get without a captain?"
    Boat.where("captain_id = ?", nil)
  end

  def self.sailboats
    puts "get sailboats?"
  end

  def self.with_three_classifications
    puts "get with three classifications?"
  end

end

# rspec spec/models/boat_spec.rb
