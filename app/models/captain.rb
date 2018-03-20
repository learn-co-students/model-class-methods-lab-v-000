class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats:[:classifications]).where('classifications.name = ?', 'Catamaran')
  end

  def self.sailors
    self.joins(boats:[:classifications]).where('classifications.name = ?', 'Sailboat').uniq
  end

  def self.talented_seafarers
    captains_names = self.seafarers
    self.where("name": captains_names)
  end

  def self.non_sailors
    sailors = self.sailors.collect {|s| s.name}
    self.where.not("name": sailors)
  end

  def sails_and_motorboat
    sailor = false
    motor = false
    self.boats.each do |boat|
      boat.classifications.each do |classification|
        if classification.name == "Sailboat"
          sailor = true
        elsif classification.name == "Motorboat"
          motor = true
        end
      end
    end
    sailor && motor ? true : false
  end

  def self.seafarers
    names = []
    self.all.each do |captain|
      if captain.sails_and_motorboat
        names << captain.name
      end
    end
    names
  end

end
