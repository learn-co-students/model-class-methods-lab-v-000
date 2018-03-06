class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: [:classifications]).where("classifications.name = ?", "Catamaran")
    
  end

  def self.sailors
    self.joins(boats: [:classifications]).where("classifications.name = ?", "Sailboat").distinct
  end

  def self.seafarers_names
    seafarers_names = []
    self.all.each do |captain|
      if captain.sails_and_motors?
        seafarers_names << captain.name
      end
    end
    seafarers_names
  end

  def self.talented_seafarers
    seafarers_names = self.seafarers_names
    self.where("name": seafarers_names)
  end

  def self.non_sailors
    sailors_names = self.sailors.collect{ |sailor| sailor.name}
    self.where.not("name": sailors_names)
  end

  def sails_and_motors?
    sails = false
    motors = false
    self.boats.each do |boat|
      boat.classifications.each do |classification|
        if classification.name == "Sailboat" 
          sails = true
        elsif classification.name == "Motorboat"
          motors = true
        end
      end
    end
    sails && motors ? true : false
  end



end
