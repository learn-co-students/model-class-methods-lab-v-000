class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    group("classifications.id")
  end

  def self.longest
    binding.pry
    includes(:boats).where("length DESC").first
    # try this as ean example joins(:classifications).group("boats.id").having('count(*)= ?', 3)
  end

end
