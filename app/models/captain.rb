class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: { name: 'Catamaran' })
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: { name: 'Sailboat' }).uniq
  end

  def self.motorboat_operators
    includes(boats: :classifications).where(classifications: { name: 'Motorboat' })
  end

  def self.talented_seafarers
    # captains of motorboars and sailboats
    where('id IN (?)', self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end

  def self.non_sailors
    where('id NOT IN (?)', self.sailors.pluck(:id))
  end
end