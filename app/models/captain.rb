class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    captains = []
    boats = Classification.select_boats("Catamaran")
    boats.each do |boat|
      captains << boat.captain
    end
    captains
  end

  def self.sailors
    captains = []
    boats = Classification.select_boats("Sailboat")
    boats.each do |boat|
      if !boat.captain.nil?
        captains << boat.captain
      end
    end
    captains.uniq!
  end

  def self.talented_seafarers
    sailboat_captains = []
    motorboat_captains = []
    sailboats = Classification.select_boats("Sailboat")
    motorboats = Classification.select_boats("Motorboat")
    sailboats.each do |s|
      sailboat_captains << s.captain
    end
    motorboats.each do |m|
      motorboat_captains << m.captain
    end
    motorboat_captains & sailboat_captains   
  end

  def self.non_sailors
    sailors = Captain.sailors
    captains = []
    Captain.all.each do |cap|
      if !Captain.sailors.include?(cap)
        captains << cap
      end
    end
    captains
  end


end
