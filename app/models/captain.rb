class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.talented_seamen
    #binding.pry
    #includes(boats: :classifications).where("classification.name = Motorboat AND classification.name = Sailboat").uniq
    #includes(boats: :classifications).where(classifications: {name: "Motorboat"}, classifications: {name: "Sailboat"}).uniq
    #joins(:boats, :classifications).where(classifications: {name: "Motorboat"}, classifications: {name: "Sailboat"}).uniq
    sailors.includes(boats: :classifications).where(classifications: {name: "Motorboat"})


  end

  def self.non_sailors
    #includes(boats: :classifications).where.not(classifications: {name: "Sailboat"})
    joins(:boats, :classifications).group(:classification_id).where.not(classifications: {name: "Sailboat"})
  end
end
