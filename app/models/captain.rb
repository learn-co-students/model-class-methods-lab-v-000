class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
  	joins(boats: :classifications).where("classifications.name = 'Catamaran'")
  end

  def self.sailors
  	joins(boats: :classifications).where("classifications.name = 'Sailboat'").distinct
  end

  def self.talented_seamen
  	joins(boats: :classifications).where("classifications.name IN ('Motorboat', 'Sailboat')").group("classifications.name").order("captains.name ASC")
  end

  def self.non_sailors
  	sailors = Captain.sailors.pluck(:id)
  	where.not(id: sailors)
  end
end
