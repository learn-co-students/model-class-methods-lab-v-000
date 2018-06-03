class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # puts "catamaran_operators"
    # Captain.all.each do |c|
    #   puts "Captain = name: #{c.name} || admiral?: #{c.admiral}"
    #   c.boats.each do |b|
    #     puts "Captain Boat = #{b.name}"
    #     b.classifications.each do |cl|
    #       puts "Boat Classification = #{cl.name}"
    #     end
    #   end
    # end

    Captain.joins(boats: :classifications).where(classifications: { name: "Catamaran" })
  end

  def self.sailors
    # puts "sailors"
    Captain.joins(boats: :classifications).where(classifications: { name: "Sailboat" }).distinct
  end

  def self.motors
    # puts "sailors"
    Captain.joins(boats: :classifications).where(classifications: { name: "Motorboat" }).distinct
  end

  def self.talented_seafarers
    puts "talented_seafarers"

    sailors = Captain.sailors.pluck(:name)
    motors = Captain.motors.pluck(:name)
    # expected: ["Captain Cook", "Samuel Axe"]

    cross = sailors.include?(motors)
    puts "cross = #{cross}"

  end

  def self.non_sailors
    # puts "non_sailors"
    sailors = Captain.sailors.pluck(:name)
    # puts "Sailors = #{sailors}"
    Captain.where.not(name: sailors)
  end

end


# rspec spec/models/captain_spec.rb
