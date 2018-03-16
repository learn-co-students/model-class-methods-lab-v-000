class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    type("Catamaran")
  end

  def self.sailors
    type("Sailboat")
  end

  def self.talented_seamen
    where("id IN (?)", self.sailors.pluck(:id) & self.type("Motorboat").pluck(:id))
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end

  def self.type (type_name)
    includes(boats: :classifications).where(classifications: {name: type_name}).uniq
  end

end
