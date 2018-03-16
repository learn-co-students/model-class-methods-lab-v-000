class Captain < ActiveRecord::Base
  has_many :boats
  has_many :boat_classifications, through: :boats
  has_many :classifications, through: :boat_classifications


  def self.catamaran_operators
    # catamaran = Classification.find_by(name: 'Catamaran')
    # all.find_all do |captain|
    #   captain.boats.any? do |boat|
    #     boat.classifications.include?(catamaran)
    #   end
    # end
    Classification.find_by(name: 'Catamaran').captains
  end

  def self.sailors
    # all.find_all do |captain|
    #   captain.boats.any? { |boat| boat.has_c('Sailboat') }
    # end
    Classification.find_by(name: 'Sailboat').captains
  end

  def self.talented_seafarers
    # motorboat = Classification.find_by(name: 'Motorboat')
    # sailboat = Classification.find_by(name: 'Sailboat')
    # all.find_all do |captain|
    #   has_motorboat = captain.boats.any? { |boat| boat.classifications.include?(motorboat) }
    #   has_sailboat = captain.boats.any? { |boat| boat.classifications.include?(sailboat) }
    #   has_motorboat && has_sailboat
    # end
    includes(:classifications).where(classifications: { name: %w[Sailboat Motorboat] })
  end

  def self.non_sailors
    # all.reject do |captain|
    #   captain.boats.any? { |boat| boat.has_c('Sailboat') }
    # end
    includes(:classifications).where.not(classifications: { name: %w[Sailboat Motorboat] })
  end
end
