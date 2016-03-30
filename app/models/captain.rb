require 'pry'

class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: :classifications).where(classifications: { name: 'Catamaran' })
  end 

  def self.sailors
    joins(boats: :classifications).where(classifications: { name: 'Sailboat' }).uniq
  end

  def self.motorboaters
    joins(boats: :classifications).where(classifications: { name: 'Motorboat' }).uniq
  end 

  def self.talented_seamen
    where("name IN (?)", self.sailors.pluck(:name) & self.motorboaters.pluck(:name))
  end

  def self.non_sailors
    where("name not IN (?)", self.sailors.pluck(:name))
  end  

end
