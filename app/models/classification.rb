class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    where("name IN (?)", self.all.pluck(:name))
  end

  def self.longest
    joins(boats: :boat_classifications).order('length DESC').distinct.limit(2)
  end
end

