class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    all
  end

  def self.longest
    where('Id IN (?)', Boat.order('length DESC').first.classifications.pluck(:id))
  end
end
