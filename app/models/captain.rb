class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # self.joins(:classifications).where(classifications: {name: "Catamaran"})
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboaters
    includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.non_sailors
    # look in Captions Table, run .sailros method, return ID's that ARE NOT sailors
    where.not("id IN(?)", self.sailors.pluck(:id))
  end

  def self.talented_seamen
    # look in Captons Table, run sailors method, return ID's that ARE sailors
    # Take those results and do the same for Moterboaters
    where("id IN(?)", self.sailors.select(:id) & self.motorboaters.select(:id))
  end
end
