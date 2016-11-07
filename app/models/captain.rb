class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats:[:classifications]).where(classifications:{name: "Catamaran"})
  end

  def self.sailors
    self.joins(boats:[:classifications]).where(classifications:{name: "Sailboat"}).distinct
  end

  def self.motorboators
    self.joins(boats:[:classifications]).where(classifications:{name: "Motorboat"}).distinct
  end


  def self.talented_seamen
    self.where("id in (?)", self.sailors.pluck(:id) & self.motorboators.pluck(:id))
  end

  def self.non_sailors
    self.where.not("id in (?)", self.sailors.pluck(:id))
  end
end
