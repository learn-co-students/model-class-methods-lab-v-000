class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications
  
  
  class << self
    def first_five
      limit 5
    end
    
    def dinghy
      where('length < ?', 20)
    end
    
    def ship
      where('length >= ?', 20)
    end
    
    def last_three_alphabetically
      order(name: :desc).limit 3
    end
    
    def without_a_captain
      where(captain_id: nil)
    end
    
    def sailboats
      #Return all Boat objects that have a classification. 
      #Filter further to a classification with a name of Sailboat.
      joins(:classifications).where(classifications: { name: 'Sailboat' })
    end
    
    def with_three_classifications
      #A boat object for every boat/classification record.
      #Group records with identical boat ids into a single record.
      #Of those groups, return the ones that have a classification_id count of 3.
      joins(:classifications).group('boats.id').having('COUNT(classification_id) = 3')
    end
    
    def longest
      order(length: :desc).limit(1).first
    end
  end
  
  
end
