class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: :classifications).where(classifications: {name: 'Catamaran'})
  end

  def self.sailors
    joins(boats: :classifications).where(classifications: {name: 'Sailboat'}).uniq
      end

  def self.talented_seafarers
    joins(boats: :classifications).group('classifications.name').order('captains.name ASC').where("classifications.name = ? OR classifications.name = ?",'Motorboat','Sailboat')
  end

  def self.non_sailors
    where.not(name: self.sailors.pluck(:name))
  end

end
