class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    #returns captains of catamarans
    self.joins(boats: [:classifications]).where("classifications.name = ?", "Catamaran").uniq

  end

  def self.sailors
    #returns captains of sailboats
    self.joins(boats: [:classifications]).where("classifications.name = ?", "Sailboat").uniq

  end

  def self.talented_seafarers
    #returns captains of motorboats and sailboats
    binding.pry
    self.joins(boats: :classifications).where(["classifications.name = ? AND classifications.name = ?", "Sailboat", "Motorboat"])

  end

  def self.non_sailors
    #returns captains who are not captains of sailboats
    self.joins(boats: [:classifications]).where("classifications.name != ?", "Sailboat").uniq

  end


  private

    # def classification_name(name)
    #   self.table.
    # end

    def self.table
      Classification.arel_table
    end

end
