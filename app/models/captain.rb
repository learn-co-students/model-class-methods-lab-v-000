class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # joins(:id).where('boat.classification_id' => 'catamaran')
     includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboaters
    includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.non_sailors
    # includes(boats: :classifications).where.not(classifications: {name: "Sailboat"}).uniq
     where.not("id IN (?)", self.sailors.pluck(:id))
  end

  def self.talented_seamen
    # where("id IN(?)", self.sailors.select(:id) & self.motorboaters.select(:id))
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
  end

end
