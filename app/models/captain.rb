class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    catamaran_class = Classification.find_by(:name => "Catamaran")
    includes(boats: [:classifications]).where('classification_id = ?', catamaran_class.id)
  end

  def self.sailors
    sailboat_class = Classification.find_by(:name => "Sailboat")
    includes(boats: [:classifications]).where('classification_id = ?', sailboat_class.id).distinct
  end

  def self.motorboat_operators
    motorboat_class = Classification.find_by(:name => "Motorboat")
    includes(boats: [:classifications]).where('classification_id = ?', motorboat_class.id).distinct
  end

  def self.talented_seafarers
    where("id IN (?)", self.motorboat_operators.pluck(:id)).where( "id IN (?)", self.sailors.pluck(:id))
  end

  def self.non_sailors
    where.not( "id IN (?)", self.sailors.pluck(:id))
  end

end
