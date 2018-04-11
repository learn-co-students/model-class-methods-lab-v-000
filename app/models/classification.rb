class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    all
  end

  def self.longest
    # Boat.longest.classifications
    longest = Boat.longest.collect {|i| i.classifications}
    longest_ids = longest.collect {|i| i.ids}
    Classification.where(id: longest_ids.flatten)
  end

end
