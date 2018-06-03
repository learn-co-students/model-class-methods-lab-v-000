class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    puts "catamaran_operators"
    Captain.joins(boats: :classifications).where(classifications: { name: "Catamaran" })
  end

  def self.sailors
    puts "sailors"
    # Captain.all.each do |c|
    #   puts "Captain = name: #{c.name} || admiral?: #{c.admiral}"
    #   c.boats.each do |b|
    #     puts "Captain Boat = #{b.name}"
    #     b.classifications.each do |cl|
    #       puts "Boat Classification = #{cl.name}"
    #     end
    #   end
    # end
  end

  def self.talented_seafarers
    puts "talented_seafarers"
  end

  def self.non_sailors
    puts "non_sailors"
  end


end


# rspec spec/models/captain_spec.rb
