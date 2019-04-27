class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    group("classifications.id")
  end

  def self.longest
    includes(:boats).where(boats: {length: length}).order("length DESC").first.classifications
  end

end
