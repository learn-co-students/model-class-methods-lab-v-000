class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(
      classifications: {name: 'Catamaran'}
    )
  end

  def self.sailors
    includes(boats: :classifications).where(
      classifications: {name: "Sailboat"}
    ).uniq
  end

  def self.talented_seamen
    motorboats = self.includes(boats: :classifications).where(
      classifications: {name: "Motorboat"}
    ).uniq

    where('id IN (?)', motorboats.ids & self.sailors.ids)
  end

  def self.non_sailors
    where.not('id IN (?)', self.sailors.ids)
  end
end
