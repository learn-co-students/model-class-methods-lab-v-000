class Captain < ActiveRecord::Base
  has_many :boats

  private

  def self.catamaran_operators
    Captain.includes(boats: [:classifications]).where('classifications.name = ?', "Catamaran").references(:classifications).uniq
  end

  def self.sailors
    Captain.includes(boats: [:classifications]).where('classifications.name = ?', "Sailboat").references(:classifications).uniq
  end

  def self.motorboaters
    #really man
    Captain.includes(boats: [:classifications]).where('classifications.name = ?', "Motorboat").references(:classifications).uniq
  end

  def self.talented_seamen
    arr = sailors & motorboaters #single & is intersection between two arrays
    Captain.where(id: arr.map(&:id))
  end

  def self.non_sailors
    non_sailors = Captain.all - sailors
    Captain.where(id: non_sailors.map(&:id))
  end
end
