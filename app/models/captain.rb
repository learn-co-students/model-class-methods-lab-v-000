class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    results = []
    Captain.all.each do |capt|
      if capt.boats.joins(boat_classifications: :classification).where('classifications.name' => "Catamaran") != ""
        results << capt 
      end 
    end 
    results 
  end

  def self.sailors 
  end 

  def self.talented_seafarers 
  end 

  def self.non_sailors 
  end 
end
