class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    # puts "get all"
    Classification.all
  end

  def self.get_boats
    boats = {}
    Classification.all.each do |classification|
      classification.boats.each do |boat|
        boats[boat.name] = boat.length
      end
    end
    boats = boats.sort_by { |name, length| length }
    boats
  end

  def self.longest
    puts "get classifications for the longest boat"
    boats = Classification.get_boats
    puts "boats = #{boats}"
    # Classification.joins(:boats).order(boats: length)
  end

end

# rspec spec/models/classification_spec.rb

# https://stackoverflow.com/questions/882070/sorting-an-array-of-objects-in-ruby-by-object-attribute
