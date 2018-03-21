class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    @boats = Boat.all
    @boats[0..4]
  end

  def self.dinghy
    @boats = Boat.all
    dinghy = []
    @boats.collect do |boat|
      if boat.length <= 20
        dinghy << boat
      end
    end
  end

end
