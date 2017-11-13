class Captain < ActiveRecord::Base
  has_many :boats

    def self.catamaran_operators
      joins(boats: :classifications).where(classifications: {name:'Catamaran'})
    end

    def self.sailors
      joins(boats: :classifications).where(classifications: {name: 'Sailboat'}).distinct
    end

    def self.motorboats
      joins(boats: :classifications).where(classifications: {name: 'Motorboat'})
    end

    def self.talented_seamen
      where('ID in (?)', self.sailors.pluck(:id) & self.motorboats.pluck(:id)) #more efficient, doesn't have to do ID = .. or ID = .. it just does ID IN (array of all possbiel ids)
    end

    def self.non_sailors
      where.not('ID in (?)', self.sailors.pluck(:id))
    end
end
