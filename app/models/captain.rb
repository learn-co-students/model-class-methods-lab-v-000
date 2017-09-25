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
end
