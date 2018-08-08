class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    select(:name)
  end

  def self.longest
    joins(:boat_classifications).where("boat_id IN (?)", Boat.longest.pluck(:id))
  end

end
