class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # self.includes(boats: :classifications).where('classification.name = ?', Catamaran )
  end

  def self.sailors
  end 

  def self.talented_seafarers
  end 

  def self.non_sailors
    # self.where(["classification.name = :classification_name and captain_id = :captain_id", { classification_name: "Sailboat", captain_id: false }])
  end 
end
