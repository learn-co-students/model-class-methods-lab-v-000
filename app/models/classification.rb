class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

#returns all classifications
  def my_all

  end

#returns the classifications for the longest boat
  def longest

  end
end
