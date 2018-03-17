class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {:name => "Catamaran"}).uniq
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {:name => "Sailboat"}).uniq
  end

  def self.talented_seamen
    includes(boats: :classifications).where(classifications: {:name => ["Sailboat", "Motorboat"] }).uniq
  end

  def self.motorboaters
    self.includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seamen
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end

end
