class Captain < ActiveRecord::Base
  has_many :boats
  
  def self.catamaran_operators
    self.includes(boats: [:classifications]).where(:classifications => {name: "Catamaran"})
  end

  def self.sailors
    # binding.pry
    self.includes(boats: [:classifications]).where(:classifications => {name: "Sailboat"}).uniq
  end

  def self.talented_seafarers
     s = self.sailors.pluck(:id)
     m = self.includes(boats: [:classifications]).where(:classifications => {name: "Motorboat"}).uniq.pluck(:id)
     self.where("id IN (?)" , s & m )
  end

  def self.non_sailors
    # binding.pry
    self.where.not("id IN (?)", self.sailors.pluck(:id))
    # self.includes(boats: [:classifications]).where.not(:classifications => {name: "Sailboat"})
  end
  
end
# Client.where("orders_count = ? AND locked = ?", params[:orders], false)