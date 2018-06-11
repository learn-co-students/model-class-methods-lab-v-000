class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications


  def Classification::my_all
    self.all

  end

  def Classification::longest
    self.joins(:boats).limit(2).order("length desc")

  end
end
