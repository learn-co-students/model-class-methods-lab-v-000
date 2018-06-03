class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    # puts "get all"
    Classification.all
  end

  def self.longest
    # puts "get classifications for the longest boat"

    # NOTE : Since the association exists to the Boat class, can define these methods in that class and call them here
    Boat.longest.classifications
  end

end

# rspec spec/models/classification_spec.rb

# https://stackoverflow.com/questions/882070/sorting-an-array-of-objects-in-ruby-by-object-attribute
