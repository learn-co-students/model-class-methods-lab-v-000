class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications
  def self.first_five
  	self.all.limit(5)
  end

  def classification_names
    self.classifications.map{|cls| cls.name}
  end

  def self.dinghy
    self.all.where('length <20')
  end

  def self.ship
    self.all.where('length >20')
  end

  def self.last_three_alphabetically
    self.all.order('name desc').limit(3)
  end

  def self.without_a_captain
    self.all.where(captain: nil)
  end

  def self.sailboats
    self.all.find_all do |boat|
      boat.classifications.any?{|c| c.name=="Sailboat"}
    end
  end

  def self.with_three_classifications
    self.all.find_all{|boat| boat.classifications.count==3}
  end


end
