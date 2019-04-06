class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    boats = []
    captains = []

    Boat.all.each do |boat|
      if boat.classifications.find {|clas| clas.name == "Catamaran"}
        boats << boat
      end
    end

    boats.each do |boat|
      if !captains.include?(boat.captain)
        captains << boat.captain
      end
    end
    captains
  end

  def self.sailors

    boats = []
    captains = []

    Boat.all.each do |boat|
      if boat.captain.present?
        if boat.classifications.find {|clas| clas.name == "Sailboat"}
          boats << boat
        end
      end 
    end

    boats.each do |boat|
      if !captains.include?(boat.captain)
        captains << boat.captain
      end
    end
    captains
  end

  def self.talented_seafarers
    boats = []
    motor_captains = []

    Boat.all.each do |boat|
      if (boat.classifications.find {|clas| clas.name == "Motorboat"})
        boats << boat
      end
    end

    boats.each do |boat|
      if !motor_captains.include?(boat.captain)
        motor_captains << boat.captain
      end
    end

    talents = []

    motor_captains.each do |capt|
      if Captain.sailors.include?(capt)
        talents << capt
      end
    end
    talents
  end

  def self.non_sailors
    Captain.all - Captain.sailors
  end
end
