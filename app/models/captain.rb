class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # puts "catamaran_operators"
    Captain.joins(boats: :classifications).where(classifications: { name: "Catamaran" })
  end

  def self.sailors
    # puts "sailors"
    Captain.joins(boats: :classifications).where(classifications: { name: "Sailboat" }).distinct
  end

  def self.talented_seafarers
    puts "talented_seafarers"
    # Captain.joins(boats: :classifications).where(classifications: { name: ["Sailboat", "Motorboat"] })
    # Captain.joins(boats: :classifications).where('classifications.name = ? AND classifications.name = ?', "Sailboat", "Motorboat")
    Captain.joins(boats: :classifications).select("*").group("captains.name, boats.id").having("classifications.name = ? AND classifications.name = ?", "Sailboat", "Motorboat")

    boats = Captain.joins(boats: :classifications)
    msboats = boats.select("*").group("captains.name, boats.id").where("classifications.name = ? OR classifications.name = ?", "Sailboat", "Motorboat")
    mscaptains = msboats.select("*, COUNT(boats.id)").group("captains.name").having("COUNT(boats.id) = 2")
    puts "mscaptains = #{mscaptains}"
    mscaptains
  end

  def self.non_sailors
    puts "non_sailors"
    # Captain.all.each do |c|
    #   puts "Captain = name: #{c.name} || admiral?: #{c.admiral}"
    #   c.boats.each do |b|
    #     puts "Captain Boat = #{b.name}"
    #     b.classifications.each do |cl|
    #       puts "Boat Classification = #{cl.name}"
    #     end
    #   end
    # end
    Captain.joins(boats: :classifications).where.not(classifications: { name: "Sailboat" }).distinct
  end


end


# rspec spec/models/captain_spec.rb
