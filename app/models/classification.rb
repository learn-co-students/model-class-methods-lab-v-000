class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications
  has_many :captains, through: :boats

  def Classification::my_all
    self.all
  end

  def Classification::longest
    boat = Boat.order(:length).last
    boat.classifications
  end
end
