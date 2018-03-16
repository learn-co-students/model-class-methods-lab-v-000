class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  #SELECT 'classifications'.* FROM 'classifications'
  def self.my_all
    self.all
  end

  #SELECT 'classifications'.* FROM 'classifications'
  #INNER JOIN 'boat_classifications' ON 'boat_classifications'.'classification_id' = 'classifications'.'id'
  #INNER JOIN 'boats' ON 'boats'.'id' = 'boat_classifications'.'boat_id'
  #ORDER BY length DESC LIMIT 2
  def self.longest
    self.joins(:boats).order('length DESC').limit(2)
  end
end
