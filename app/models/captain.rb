class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # self.all.select do |captain|
    #   captain.boats.each do |boat|
    #     boat.classifications.find_by(name: 'Catamaran')
    #   end
    # end
    includes(boats: :classifications).where(classifications: {name: 'Catamaran'}).distinct
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: 'Sailboat'}).distinct
  end

  def self.talented_seafarers
    includes(boats: :classifications).where(classifications: {name: 'Motorboat', name: 'Sailboat'}).distinct
  end

  def self.non_sailors
    
  end
end
