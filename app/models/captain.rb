class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats

  def self.catamaran_operators
    joins(:classifications).where(:classifications => {:name => "Catamaran"})
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
    # joins(:classifications).where(:classifications => {:name => "Sailboat"}).uniq
  end

  def self.motorboaters
    includes(boats: :classifications).where("classifications.name" => "Motorboat").uniq
  end

  def self.talented_seamen
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
    # sail = "Sailboat"
    # joins(:classifications).where('name != ?', sail)
    # joins(:classifications).where.not(:classifications => {:name => "Sailboat"} ).uniq
  end
end
