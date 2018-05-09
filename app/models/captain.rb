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

  def self.motorboat_operators
    joins(boats: :classifications).where(classifications: { name: 'Motorboat' }).select("captains.*").distinct
  end

  def self.sailors
    #returns captains with sailboats
    joins(boats: :classifications).where(classifications: { name: 'Sailboat' }).select("captains.*").distinct
  end

  def self.talented_seafarers
    #returns captains of motorboats and sailboats
    #returning a collection that references both the captains and the boats table and the classifications(boat_classifications)tables
    #joins(boats: :classifications).where(classifications: { name: ['Sailboat','Motorboat'] }).select("captains.*").distinct
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
    #IN allows you to test if an expression matches any value in a list of values.
    #return captains whose id is in the following list of values, the id's from the sailors method and the id's from the motorboat_operators method

  end
end
