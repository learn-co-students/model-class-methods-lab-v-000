class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # all.select do |c|
      # c.boats.catamarans
    # end
    
      includes(boats: :classifications).where(classifications: { name: 'Catamaran' })
    # end
  end

  def self.sailors
  end

  def self.talented_seafarers
  end

  def self.non_sailors
  end
end
