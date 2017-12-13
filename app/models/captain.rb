class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where("classifications.name" => "Catamaran")
  end

  def self.sailors
    distinct.includes(boats: :classifications).where("classifications.name" => "Sailboat")
  end

  def self.motorboats
    distinct.includes(boats: :classifications).where("classifications.name" => "Motorboat")
  end

  def self.talented_seamen
    where("name IN (?)", self.sailors.pluck(:name) & self.motorboats.pluck(:name))
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end
end
