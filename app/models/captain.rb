class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    #binding.pry
    includes(boats: :classifications)
    .where(classifications: {name: 'Catamaran'}).uniq
  end

    def self.sailors
      #binding.pry
      joins(boats: :classifications)
      .where(classifications: {name: 'Sailboat'}).uniq
    end

    def self.motorboaters
      #binding.pry
      joins(boats: :classifications)
      .where(classifications: {name: 'Motorboat'}).uniq
    end

  def self.talented_seafarers
    self.where("id in (?)",self.motorboaters.pluck(:id) &  self.sailors.pluck(:id))
  end

  def self.non_sailors
    self.where.not("id in (?)", self.sailors.pluck(:id))
  end

end
