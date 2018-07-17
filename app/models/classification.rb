class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    where()
  end



  def self.longest
    Classification.joins(:boats).group('classifications.id').where('boats.id IN (?)', Boat.order('length DESC').limit(1).pluck(:id))
  end
end
