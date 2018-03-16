class Captain < ActiveRecord::Base
  has_many :boats

  private

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"}).uniq
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.talented_seamen
    motorboaters = includes(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
    where("id IN (?)", self.sailors.pluck(:id) & motorboaters.pluck(:id))
  end

  def self.non_sailors
    where("id IN (?)", self.all.pluck(:id)-self.sailors.pluck(:id))
  end

end
