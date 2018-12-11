class Captain < ActiveRecord::Base
  has_many :boats


  def self.catamaran_operators
    self.joins(boats: :classifications).group('captain_id').where(classifications: {name: ["Catamaran"]})
  end

  def self.sailors
    self.joins(boats: :classifications).group('captain_id').where(classifications: {name: ["Sailboat"]})
  end

  def self.motorboat_operators
    self.joins(boats: :classifications).group('captain_id').where(classifications: {name: ["Motorboat"]})
  end


  def self.talented_seafarers
    where("id in (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end

  def self.non_sailors
   where.not("id in (?)", self.sailors.pluck(:id))
  end









end
