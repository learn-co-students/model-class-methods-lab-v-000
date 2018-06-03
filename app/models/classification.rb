class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    # puts "get all"
    Classification.all
  end

  def self.longest
    puts "get classifications for the longest boat"
    # Classification.joins(:boats).order(length).limit(1)
  end

end

# rspec spec/models/classification_spec.rb
