class Captain < ActiveRecord::Base
  has_many :boats
  has_many :boat_classifications, through: :boats
  has_many :classifications, through: :boat_classifications

  def self.catamaran_operators
    all.joins(:classifications).where("classifications.name =  ?", 'Catamaran').distinct
  end

  def self.boater(type)
    all.joins(:classifications).where(classifications: {name: type}).distinct
  end

  def self.sailors
    boater("Sailboat")
  end

  def self.motorboaters
    boater("Motorboat")
  end

  def self.talented_seamen
    ids = self.sailors.pluck(:id).collect do |id|
      id if self.motorboaters.pluck(:id).include?(id)
    end
    where(id: ids.compact)
  end

  def self.non_sailors
    where.not(id: self.sailors.pluck(:id))
  end

end
