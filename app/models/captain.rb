class Captain < ActiveRecord::Base
  has_many :boats

# This one does not use a query for this class. Can it since it only has a has_many association?
  def self.catamaran_operators
    catamaran_boats = Boat.all.catamarans
    operators = []
    catamaran_boats.collect do |boat|
      operators << boat.captain
    end
    operators
  end

  def self.sailors
    joins(:boats).group(:boats).includes({boat: classifications}).where({boat: classifications {name: "Sailboat"}})

  end

  def self.talented_seafarers
  end

  def self.non_sailors
  end

end


# def self.with_three_classifications
#   joins(:classifications).group("boats.id").having('count(*)= ?', 3)
# end
