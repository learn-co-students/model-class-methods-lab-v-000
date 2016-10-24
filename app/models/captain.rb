class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: 'Catamaran'}).uniq
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: 'Sailboat'}).uniq
    #returns captains with sailboats
  end

  def self.motorboaters
    includes(boats: :classifications).where(classifications: {name: 'Motorboat'}).uniq
  end

  def self.talented_seamen
    where('id IN (?)', self.sailors.pluck(:id)).where('id IN (?)', self.motorboaters.pluck(:id))
    #returns captains of motorboats and sailboats
  end

  def self.non_sailors
    where.not('id IN (?)', self.sailors.pluck(:id))
    #returns people who are not captains of sailboats
  end



end
