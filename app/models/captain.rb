class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.includes(boats: :classifications).where(:classifications => {:name => "Catamaran"})
  end

  def self.sailors
    self.includes(boats: :classifications).where(:classifications => {:name => "Sailboat"}).distinct
  end

  def self.talented_seamen

    motorboat_operators = self.includes(boats: :classifications).where(:classifications => {:name => "Motorboat"}).distinct

    all = motorboat_operators.pluck(:id) & self.sailors.pluck(:id)
    self.where(id: all)
  end

  def self.non_sailors
    not_sailboats = Classification.where.not(name: "Sailboat").pluck(:name)
    sailors = self.sailors.pluck(:id)
    not_sailors = self.includes(boats: :classifications).where(:classifications => {:name => not_sailboats}).distinct.pluck(:id)
    rest = not_sailors - sailors
    self.where(id: rest)
  end

end
