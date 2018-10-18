require 'pry'
class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    #binding.pry
    includes(boats: :classifications).where(classifications:{name:"Catamaran"})
  end

  def self.sailors
    #binding.pry
    includes(boats: :classifications).where(classifications:{name:"Sailboat"}).uniq
  end

  def self.motorboats
    #binding.pry
    includes(boats: :classifications).where(classifications:{name:"Motorboat"}).uniq
  end

  def self.talented_seafarers
    #binding.pry
    a = self.motorboats.pluck(:id)
    b = self.sailors.pluck(:id)
    c = a&b
    where("id in(?)", c).uniq
  end

  def self.non_sailors
    b = self.sailors.pluck(:id)
    where.not("id in(?)", b).uniq
  end


end
