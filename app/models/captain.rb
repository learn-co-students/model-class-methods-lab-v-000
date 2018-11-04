class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators  
    Captain.joins(boats: :classifications).group('captain_id').where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    Captain.joins(boats: :classifications).group("captain_id").where(classifications: {name: "Sailboat"})
  end

  def self.motorboat_operators
    Captain.joins(boats: :classifications).group('captain_id').where(classifications: {name: "Motorboat"})
  end

  def self.talented_seafarers
    Captain.where('id IN (?)', self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end

  def self.non_sailors
    Captain.where.not('id IN (?)', self.sailors.pluck(:id))
  end

end
