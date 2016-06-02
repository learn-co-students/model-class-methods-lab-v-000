class Captain < ActiveRecord::Base
  has_many :boats
  
  class << self
    def catamaran_operators
      joins(:boats => :classifications).where(:classifications => {name: 'Catamaran'})
    end
    
    def sailors
      joins(:boats => :classifications).where(:classifications => {name: 'Sailboat'}).group('captains.id')
    end
    
    def uses_a_motor
      joins(:boats => :classifications).where("classifications.name = ?", 'Motorboat').group('captains.id')
    end
    
    def talented_seamen
      where("id IN (?)", talented_ids)
    end
    
    def non_sailors
      where.not("name IN (?)", sailors.pluck(:name))
    end
    
    def talented_ids
      sailors.pluck(:id) & uses_a_motor.pluck(:id)
    end
  end
end
