class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: [:classifications]).where("classifications.name = ?", "Catamaran").references(:classifications)
  end

  def self.sailors
    includes(boats: [:classifications]).where("classifications.name = ?", "Sailboat").references(:classifications).distinct
  end

  def self.motorboaters
    includes(boats: [:classifications]).where("classifications.name =?", "Motorboat").references(:classifications).distinct
  end

  def self.talented_seamen
    # Topic.find(:all, :conditions => { :forum_id => @forums.map(&:id) })

    where("id IN (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end
end
