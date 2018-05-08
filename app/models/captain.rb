class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    #you have the ability to directly join onto the boats table because of the has_many relationships
    #you can join onto a nested table, a table that boats can join on to, in this case classifcations
    #joining onto classifcations also joins you to the join table boat_classifications

    #the boat_classifications table: gives you access to the relationships between boats and classifications
    #the classifications table: will give you access to the classification name

    #from that large pool of data, return a collection where
    #in the classifications table the name column is equal to 'Catamaran'
    joins(boats: :classifications).where(classifications: { name: 'Catamaran' }).select("captains.*")
  end

  def self.sailors
    #returns captains with sailboats
    joins(boats: :classifications).where(classifications: { name: 'Sailboat' }).select("captains.*").distinct
  end

  def self.talented_seafarers
    byebug
  end
end
