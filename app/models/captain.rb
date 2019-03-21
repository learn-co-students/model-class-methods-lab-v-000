class Captain < ActiveRecord::Base
  has_many :boats

  # Captain::catamaran_operators returns all captains of catamarans

  # def self.catamaran_operators
  #   binding.pry
  #   # self.includes(:classifications).where(classifications: {"name" = "Catamaran"})
  #   # self.joins(:classifications).where(classifications: {name: "Catamaran"})
  #    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  #
  # end


  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboat_operators
    includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seafarers
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end


end
