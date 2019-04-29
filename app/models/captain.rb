class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
      self.joins(boats: :classifications).where("classifications.name = ?", "Catamaran")
    end

    def self.sailors
      self.joins(boats: :classifications).where("classifications.name = ?", "Sailboat").distinct
    end

    def self.motorboatists
      self.joins(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
    end

    def self.talented_seafarers
      self.where("id IN (?)", self.sailors.pluck(:id) & self.motorboatists.pluck(:id))
    end

    def self.non_sailors
      self.where.not("id IN (?)", self.sailors.pluck(:id))
    end

end
