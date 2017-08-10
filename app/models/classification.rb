class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.select('*')
  end

  def self.longest
    self.joins(:boats).where('boats.id IN (?)', self.joins(:boats).order('boats.length desc').limit(1).pluck('boats.id'))
  end

end
