class Captain < ActiveRecord::Base

  has_many :boats

  def self.catamaran_operators
    self.includes(boats: :classifications).where(:classifications => {:name => "Catamaran"})
  end

  def self.sailors
    self.includes(boats: :classifications).where(:classifications => {:name => "Sailboat"}).distinct
  end

  def self.talented_seamen
    talented_seamen = self.includes(boats: :classifications).where(:classifications => {:name => "Motorboat"}).distinct

    everyone = talented_seamen.pluck(:id) & self.sailors.pluck(:id)
    self.where(id: everyone)
  end

  def self.non_sailors
    non_boats = Classification.where.not(name: "Sailboat").pluck(:name)
    sailors = self.sailors.pluck(:id)
    non_captains = self.includes(boats: :classifications).where(:classifications => {:name => non_boats}).distinct.pluck(:id)
    rest = non_captains - sailors
    self.where(id: rest)
  end
end
