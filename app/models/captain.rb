class Captain < ActiveRecord::Base
  has_many :boats
  default_scope {joins(:boats).merge(Boat.with_classifications)}

  def self.catamaran_operators
    where("c.name = 'Catamaran'")
  end

  def self.sailors
    where("c.name = 'Sailboat'").distinct
  end

  def self.talented_seafarers
    group("captains.id").where("c.name = 'Sailboat' OR c.name = 'Motorboat'").having("COUNT(captains.id) > 1 AND SUM(c.name = 'Sailboat') >= 1 AND SUM(c.name = 'Motorboat') >= 1")
    # find the captains that command both a motorboat and sailboat
    # group by boats having classifications of either motorboat or sailboat, then select boats that have the same captain
  end
  
  def self.non_sailors
    group('captains.id').where("c.name != 'Sailboat'")
    # SELECT * FROM (join the tables) GROUP BY captains.id WHERE c.name != 'Sailboat' => all captains of non-sailboats
    # find captains whose ships does not include a sailboat => group by captains id, where their boats do not include a sailboat
  end

end
