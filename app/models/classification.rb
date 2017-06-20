class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

  def self.longest
    includes(boats: :classifications).order("boats.length DESC").limit(2).uniq
  end

end
