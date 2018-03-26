class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # self.select("name").joins("boats").joins("classifications").where("classifications.name == ?", 'Catamaran')


    self.joins("boats").joins("boat_classifications").joins("classifications").where("classifications.name == ?", 'Catamaran')
  end

end
