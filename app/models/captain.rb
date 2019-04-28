class Captain < ActiveRecord::Base
  has_many :boats

# This one does not use a query for this class. Can it since it only has a has_many association?
  def self.catamaran_operators
    # catamaran_boats = Boat.all.catamarans
    # operators = []
    # catamaran_boats.collect do |boat|
    #   operators << boat.captain
    # end
    # operators
    includes(boats: :classifications).group("id").where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    includes(boats: :classifications).group("id").where(classifications: {name: "Sailboat"})
  end

  def self.motors
    includes(boats: :classifications).group("id").where(classifications: {name: "Motorboat"})
  end

  def self.talented_seafarers
    where("id IN (?)", self.sailors.pluck(:id) & self.motors.pluck(:id))
  end

  def self.non_sailors
    where("id NOT IN (?)", self.sailors.pluck(:id))
  end

end


# def self.with_three_classifications
#   joins(:classifications).group("boats.id").having('count(*)= ?', 3)
# end
