class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: 'Catamaran'}).distinct
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: 'Sailboat'}).distinct
  end

  def self.motorboats
    includes(boats: :classifications).where(classifications: {name: 'Motorboat'}).distinct
  end

  def self.talented_seamen
    where("id in (?)", self.motorboats.pluck(:id) & self.sailors.pluck(:id))
  end

  def self.non_sailors
    where("id not in (?)", self.sailors.pluck(:id))
  end
end
