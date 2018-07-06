class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    captains_of("Catamaran")
  end

  def self.sailors
    captains_of("Sailboat")
  end

  def self.talented_seafarers
    captains = []
    all.each do |cap|
      if captains_of("Motorboat").include?(cap)
        if captains_of("Sailboat").include?(cap)
          captains << cap
        end
      end
    end
    captains
  end

  def self.non_sailors
    captains = []
    all.each do |cap|
      if !captains_of("Sailboat").include?(cap)
        captains << cap
      end
    end
    captains
  end

  def self.captains_of(klass)
    all.find_all do |captain|
      captain if !!captain.name && captain.boats.any? do |boat|
        boat.classifications.any? do |classification|
          classification.name.include?(klass)
        end
      end
    end
  end

end
