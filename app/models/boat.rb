class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    order('created_at ASC').limit(5)
  end

  def self.dinghy
    #boats shorter than 20 ft
    where("length < ?", 20) 
  end

  def self.ship
    where("length >= ?", 20) 
  end

  def self.last_three_alphabetically
    order('name DESC').limit(3)
  end

  def self.without_a_captain
    where("captain_id is null")    
  end

  def self.sailboats
    joins(:classifications).select('boats.id').where('classifications.name like ?', "Sailboat")
  end

  def self.catamarans
    joins(:classifications).select('boats.id').where('classifications.name like ?', "catamaran")
  end

  def self.motorboats
    joins(:classifications).select('boats.id').where('classifications.name like ?', "motorboat")
  end

  def self.with_three_classifications
    joins(:classifications).select('boats.id').group('boats.id').having('count(classifications.id) == 3')
  end

  def self.longest
    where("length == ?", maximum(:length)).first
  end

end
