class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.where(id: Boat.joins(:classifications).select(:captain_id).where("classifications.name = 'Catamaran'"))
  end

  def self.sailors
    self.where(id: Boat.joins(:classifications).select(:captain_id).where("classifications.name = 'Sailboat'"))
  end

  def self.talented_seamen
    # self.where(id: Boat.joins(:classifications).select(:captain_id).where("classifications.name = 'Sailboat'"))
  end

  def self.non_sailors
    self.where(id: Boat.joins(:classifications).select(:captain_id).where("classifications.name != 'Sailboat'")).where.not(sailors)
  end
end
