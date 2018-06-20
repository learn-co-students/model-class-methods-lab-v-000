class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    select(:name).includes(boats: :classifications).where("classifications.name" => "Catamaran")
  end

  def self.sailors
    select(:name).includes(boats: :classifications).where("classifications.name" => "Sailboat").uniq
  end

  def self.motorboaters
    select(:name).includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end


  def self.talented_seafarers
    select(:name).where("id IN (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
  end

  def self.non_sailors
    select(:name).where.not("id IN (?)", self.sailors.pluck(:id))
  end
end
