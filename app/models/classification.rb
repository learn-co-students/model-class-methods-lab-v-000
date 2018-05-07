class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.select('name').uniq
  end

  def self.longest
    q = Boat.longest
    q.classifications
  end
end
