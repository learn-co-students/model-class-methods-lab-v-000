class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    Classification.all
  end

  def self.longest
    # order(boats: length: :desc).limit(1)
  end

  def classification_name
    self.name
  end

end
