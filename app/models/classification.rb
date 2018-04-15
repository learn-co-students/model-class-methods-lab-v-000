class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications
  def self.longest
    boat= Boat.order(length: :desc).first
    boat.classifications
  end
  def self.my_all
    # Classification.all.map do |c|
    #   c.name
    # end
    Classification.pluck(:name)
  end
end
