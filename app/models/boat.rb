class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications
  
#ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
#boats = Arel::Table.new(:boats, ActiveRecord::Base)
#select_manager = boats.project(Arel.star)
#select_manager.to_sql

# boats = Arel::Table.new(:boats)
 #select_manager = boats.project(Arel.star)
  
  def self.first_five
   select("boat_id").limit(5)
  end 
  
  def self.dinghy 
   where("length < 20")
  end 
  
  def self.ship
   where("length > 20")
  end 
  
  def self.last_three_alphabetically
    order(name: :DESC).limit(3)
  end 
  
  def self.without_a_captain 
    where(captain_id: nil)
  end 
  
  def self.sailboats 
    includes(:classifications).where(classifications: {name: "Sailboat"})
  end 
  
  def self.with_three_classifications
    joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")
    #includes(:classifications).gteq(3)
  end 
  
    def self.longest
    self.order('length desc').first
  end

end
