class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    all.includes(boats: :classifications).where(classifications: {name: 'Catamaran' })
  end

  def self.sailors
    all.includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboat_operators
    all.includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end



end
