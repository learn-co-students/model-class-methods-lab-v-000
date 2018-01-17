class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications
  
  def self.first_five
    limit(5) 
  end
  
  def self.dinghy
    where("length < ?", 20)
  end
  
  def self.ship
    where("length > ?", 20 )
  end
  
  def self.last_three_alphabetically
    order('name ASC').limit(3).reverse_order
  end
  
  def self.without_a_captain
    #Boat.all.select{|boat| boat.captain_id == nil}
    self.where("captain_id IS NULL")
  end
  
  def self.sailboats
    includes(:classifications).where("classifications.name = ?", 'Sailboat').references(:classifications)
  end
  
  def self.with_three_classifications
    #self.all.select{|boat| boat.classifications.count == 3}
    includes(:classifications).having("COUNT(*) = ?", 3).group('boat_id').references(:classifications)
  end
    
  # User.joins(:posts).where("posts.created_at < ?", Time.now)
  # Order.having('SUM(price) > 30').group('user_id')
  # Boat.joins(:captains, :classifications).where("classifications.name = ?", 'Catamaran') 
end
