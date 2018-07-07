class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    select(id: true)
  end

  def self.longest
    length = Boat.maximum("length")
    joins(:boats).select(:classifications).where('length = ?', length)
  end

end
