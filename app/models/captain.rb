class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: { name: 'Catamaran' })
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: { name: 'Sailboat' }).uniq
  end

  def self.motorboaters
    includes(boats: :classifications).where(classifications: { name: 'Motorboat' })
  end

  def self.talented_seamen
    where('id IN (?)', self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
  end

  def self.non_sailors
    # Item.where(Item.arel_table[:id].not_in ids_to_exclude)
    self.where(self.arel_table[:id].not_in self.sailors.pluck(:id))
  end
end
