class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats

  def self.catamaran_operators
    self.joins(:boats, :classifications).where("classifications.name = 'Catamaran'").distinct
  end

  def self.sailors
    self.joins(:boats, :classifications).where("classifications.name = 'Sailboat'").distinct
  end

  def self.motorboaters
    self.joins(:boats, :classifications).where("classifications.name = 'Motorboat'").distinct
  end

  def self.talented_seamen
    # binding.pry
    # self.sailors.joins(:boats, :classifications).where("classifications.name = 'Motorboat'").distinct
    arr = self.sailors.all & self.motorboaters.all
    self.where(id: arr.map(&:id))
  end

  def self.non_sailors
    arr = self.all - self.sailors.all
    self.where(id: arr.map(&:id))
    # binding.pry
  end

end
