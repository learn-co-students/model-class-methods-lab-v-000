class Captain < ActiveRecord::Base
  has_many :boats

# call the boats table then the column classifications (because of the has_many through association) then call the classifications table and name column
  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {:name => "Catamaran"})
  end
end
