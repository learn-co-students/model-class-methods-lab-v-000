class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications
  def self.my_all
    self.group("id")
  end
  def self.longest
    maxlen=0
    Boat.all.each{|b| if b.length>maxlen then maxlen=b.length end}
    self.includes(:boats).where(["boats.length IS ?", maxlen]).group("classifications.id")
  end
end
