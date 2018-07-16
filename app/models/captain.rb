class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications)
    .where(classifications: {name: 'Catamaran'}).uniq
  end

    def self.sailors
      #binding.pry
      includes(boats: :classifications)
      .where(classifications: {name: 'Sailboat'}).uniq
    end

  def self.talented_seafarers
    includes(boats: :classifications)
    .where(classifications: {name: 'Motorbat'})
    .where(classifications: {name: 'Sailboat'})
    .uniq
  end

  def self.non_sailors
  end

end
