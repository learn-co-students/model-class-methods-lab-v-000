class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # Category.includes(articles: [{ comments: :guest }, :tags]).find(1)
    includes(boats: [:classifications]).where("classifications.name = 'Catamaran'").references(:classifications)
  end

  def self.sailors
    includes(boats: [:classifications]).where("classifications.name = 'Sailboat'").references(:classifications).distinct
  end

  def self.motorboaters # heh
    includes(boats: [:classifications]).where("classifications.name = 'Motorboat'").references(:classifications).distinct
  end

  def self.talented_seamen
    seamen = sailors & motorboaters
    where(id: seamen.map(&:id))
  end

  def self.non_sailors
    non_sailors = all - sailors
    where(id: non_sailors.map(&:id))
  end
end
