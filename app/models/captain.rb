class Captain < ActiveRecord::Base
  has_many :boats


  def self.catamaran_operators
    joins(boats: :classifications).where(:classifications => {:name => "Catamaran"})
  end

  def self.sailors
    joins(boats: :classifications).where("classifications.name" => "Sailboat").distinct
  end

  def self.motorboaters
    joins(boats: :classifications).where("classifications.name" => "Motorboat").distinct
  end

  def self.talented_seamen
    where("name in (?)", self.sailors.pluck(:name) & self.motorboaters.pluck(:name))
  end

  def self.non_sailors
    where.not("name in (?)", self.sailors.pluck(:name))
  end
end
