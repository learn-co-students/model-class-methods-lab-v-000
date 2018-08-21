class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # all.where('boat.classifications = ?', 'Catamaran').references(:boat)
    # all.includes(:boat_classifications).where('boat.classifications = ?', 'Catamaran').references(:boat)
    # where(:boat).includes(:classifications).where('classifications.name = ?', 'Catamaran').references(:classifications)
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboats
    includes(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
  end

  def self.talented_seafarers
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboats.pluck(:id))
    # (includes(boats: :classifications).where(classifications: {name: "Motorboat"}) && includes(boats: :classifications).where(classifications: {name: "Sailboat"})).uniq
  end

 def self.non_sailors
   where.not("id IN (?)", self.sailors.pluck(:id))
 end

end
