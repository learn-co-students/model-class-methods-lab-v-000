class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    all.includes(boats: :classifications).where("classifications.name = 'Catamaran'").references(:classifications).uniq
  end

  def self.sailors
    all.includes(boats: :classifications).where("classifications.name = 'Sailboat'").references(:classifications).uniq
  end

  def self.motorboaters
    all.includes(boats: :classifications).where("classifications.name = 'Motorboat'").references(:classifications).uniq
  end

  def self.talented_seamen
    where("name in (?)", self.sailors.pluck(:name) & self.motorboaters.pluck(:name))
  end

  def self.non_sailors
    where("name not in (?)", self.sailors.pluck(:name))
  end
end
