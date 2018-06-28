class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  # scope :sailboats,

  def self.catamaran

    joins(:classifications).where("classifications.name = 'Catamaran' ")
  end

  def self.first_five
    self.all.limit(5)
  end

  def self.dinghy
    self.where(:length => 0..19)
  end

  def self.ship
    self.where(:length => 20..1000)
  end

  def self.last_three_alphabetically
    # self.find(:all, :order => :name, :limit => 3)
    order("name desc").limit(3)
  end

  def self.without_a_captain
    where(:captain_id => nil)
  end

  def self.sailboats
    joins(:classifications).where("classifications.name = 'Sailboat' ")
   end

   def self.with_three_classifications
      # binding.pry
      joins(:classifications).group("boats.id").having("COUNT(*) = 3")

   end

end
