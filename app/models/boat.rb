class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  # def self.first_five
  #   all.first(5)
  # end
  #DOESN'T WORK - not an ActiveRecord method

  def self.first_five
    all.limit(5)
  end


    # def self.dinghy
    #   all.select {|boat| boat.length < 20}
    # end
    #SELECT doesn't access the DB!

  def self.dinghy
    where("length < 20")
  end

  # def self.dinghy
  #   select("length < 20")
  # end

  #SELECT access DB but doesn't create conditionals in AR, just selects a set already labeled

  def self.ship
    where("length > 20")
  end

  def self.last_three_alphabetically
    all.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    where(captain: nil)
  end

  def self.sailboats
    includes(:classifications).where(classifications: {name: "Sailboat"})
  end

  def self.with_three_classifications
    joins(:classifications).group('boats.id').having('COUNT(*) = 3')
  end

  def self.longest
    order(length: :desc).first
  end
end
