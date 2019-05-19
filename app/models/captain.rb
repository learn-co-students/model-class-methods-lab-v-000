class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).group("name")
  end

  def self.motorboat_operators
    includes(boats: :classifications).where(classifications: {name: "Motorboat"}).group("name")
  end

  def self.talented_seafarers
    # User.where(["name = ? and email = ?", "Joe", "joe@example.com"])
    #User.where(["name = :name and email = :email", { name: "Joe", email: "joe@example.com" }])
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))

  end

end
