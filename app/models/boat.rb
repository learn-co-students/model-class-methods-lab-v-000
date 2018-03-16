class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  #SELECT 'boats'.* FROM 'boats' LIMIT 5
  def self.first_five
    self.limit(5)
  end

  #SELECT 'boats'.* FROM 'boats' WHERE (length < 20)
  def self.dinghy
    self.where('length < 20')
  end

  #SELECT 'boats'.* FROM 'boats' WHERE (length > 20)
  def self.ship
    self.where('length > 20')
  end

  #SELECT 'boats'.* FROM 'boats' ORDER BY name DESC LIMIT 3
  def self.last_three_alphabetically
    self.order('name DESC').limit(3)
  end

  #SELECT 'boats'.* FROM 'boats' WHERE 'boats'.'captain_id' IS NULL
  def self.without_a_captain
    self.where(:captain_id => nil)
  end

  #SELECT 'boats'.* FROM 'boats' INNER JOIN 'boat_classifications'
  #ON 'boat_classifications'.'boat_id' = 'boats'.'id INNER JOIN 'classifications'
  #ON 'classifications'.'id' = 'boat_classifications'.'classification_id'
  #WHERE 'classifications'.'name' = ?  [['name', 'Sailboat']]
  def self.sailboats
    self.joins(:classifications).where(classifications: { name: 'Sailboat' })
  end

  #SELECT 'boats'.* FROM 'boats' INNER JOIN 'boat_classifications'
  #ON 'boat_classifications'.'boat_id' = 'boats'.'id INNER JOIN 'classifications'
  #ON 'classifications'.'id' = 'boat_classifications'.'classification_id'
  #GROUP BY boat_id HAVING count(boats.id) = 3
  def self.with_three_classifications
    self.joins(:classifications).group(:boat_id).having('count(boats.id) = 3')
  end
end
