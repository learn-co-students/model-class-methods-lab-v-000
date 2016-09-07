class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(:boats => :classifications).where("classifications.name" => "Catamaran")
  end

  def self.sailors
    joins(:boats => :classifications).where("classifications.name" => "Sailboat").distinct
  end

  def self.talented_seamen
    joins(:boats => :classifications).where("classifications.name" => "Sailboat").merge(Classifications.where("classifications.name" => "Motorboat"))
#     captains = self.arel_table
#     sailors = self.sailors
#     skipper = self.joins(:boats => :classifications).where("classifications.name" => "Motorboat")
#     query = self.where(sailors.and(skipper))
# #    joins(:boats => :classifications).where("classifications.name = ? AND classifications.name = ?", "Sailboat", "Motorboat")
  end

end
