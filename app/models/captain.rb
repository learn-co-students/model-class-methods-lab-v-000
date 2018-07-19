class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
      self.includes(boats: :classifications).where(classifications: { name: "Catamaran"})
  end

  def self.sailors
      self.includes(boats: :classifications).where(classifications: { name: "Sailboat"}).uniq
  end

  def self.motorboatists
      self.includes(boats: :classifications).where(classifications: { name: "Motorboat"}).uniq
  end


  def self.talented_seafarers
      self.where('id IN (?)',
      self.sailors.pluck(:id) &
      self.motorboatists.pluck(:id))

  end

  def self.non_sailors
      self.where('id NOT IN (?)', self.sailors.pluck(:id))
  end


end
