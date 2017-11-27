class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.select("*")
  end

  def self.longest
    self.where(id: Boat.joins(:classifications).select("classifications.id").where(["boats.length = ?" ,Boat.maximum(:length)]))
  end
end
