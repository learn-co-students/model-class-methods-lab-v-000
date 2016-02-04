class Captain < ActiveRecord::Base
  has_many :boats
  ###Just realized I was supposed to be using AREL this whole time .-.
  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end


  def self.sailors
  	includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.talented_seamen
    motorboat_owners=includes(boats: :classifications).where(classifications: {name: "Motorboat"})
    sailboat_owners=includes(boats: :classifications).where(classifications: {name: "Sailboat"})
    motorboat_owners & sailboat_owners #This one was mind-meltingly difficult for me, and now it seems so simple
  end

  def self.non_sailors
    self.all-self.sailors
  end


end
