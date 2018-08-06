class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    all.uniq
  end

  def self.longest
    includes(boats: :boat_classifications).order('length DESC').uniq.limit(2)
  end
end
