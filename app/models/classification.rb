class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    all.select(:name)
  end

  def self.longest
    joins(:boats).group("classifications.id").order("length DESC").limit(2)
  end


end
