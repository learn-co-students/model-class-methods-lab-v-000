class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(
      classifications: {:name => 'Catamaran'}
    )
  end

  def self.sailors
    includes(boats: :classifications).where(
      classifications: {name: "Sailboat"}
    ).uniq
  end

  def self.motorboaters
    includes(boats: :classifications).where(
      classifications: {name: "Motorboat"}
    ).uniq
  end

  def self.talented_seafarers
    talents = motorboaters.pluck(:id) & sailors.pluck(:id)
    where('id IN (?)', talents)
  end

  def self.non_sailors
    s = sailors.pluck(:id)
    where('id NOT IN (?)', s)
    
  end
end
