class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.includes(boats: :classifications).uniq
  end

  def self.longest
    self.includes(boats: :classifications).order("boats.length DESC").limit(2).uniq
  end
end
