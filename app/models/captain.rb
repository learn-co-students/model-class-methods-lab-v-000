class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats

  def self.catamaran_operators
    joins(:classifications).where(:classifications => {:name => "Catamaran"})
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
    # joins(:classifications).where(:classifications => {:name => "Sailboat"}).uniq
  end

  def self.talented_seamen
    joins(:classifications).where("name = ? AND name = ?", "Sailboat", "Motorboat")
  end

  def self.non_sailors
    includes(boats: :classifications).where.not(classifications: {name: "Sailboat"}).uniq
    # sail = "Sailboat"
    # joins(:classifications).where('name != ?', sail)
    # joins(:classifications).where.not(:classifications => {:name => "Sailboat"} ).uniq
  end
end
