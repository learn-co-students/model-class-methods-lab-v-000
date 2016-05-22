class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    Classification.all
  end

  def self.longest
    longest = Boat.all.max_by {|b| b.length }
    longest.classifications #.map { |c| c.name }
  end
end
