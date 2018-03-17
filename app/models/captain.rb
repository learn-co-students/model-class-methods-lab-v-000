class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # captains have many boats, boats have many classifications 
    # http://stackoverflow.com/questions/16131201/multiple-table-joins-in-rails
    Captain.joins(:boats => :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    Captain.joins(:boats => :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboaters
    includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seamen
    Captain.where("id IN (?)", Captain.all.pluck(:id) & Boat.sailboats.pluck(:captain_id) & Captain.all.pluck(:id) & Boat.motorboats.pluck(:captain_id))
    # better answer:
    # Captain.where("id IN (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id))

    # pluck - http://apidock.com/rails/ActiveRecord/Calculations/pluck
  end

  def self.non_sailors
    Captain.where("id NOT IN (?)", Captain.all.pluck(:id) & Boat.sailboats.pluck(:captain_id))
    # better answer:
    # Captain.where.not("id IN (?)", self.sailors.pluck(:id))
  end

end



