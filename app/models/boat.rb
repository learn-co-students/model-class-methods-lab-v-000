class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def Boat::first_five
     Boat.limit(5)
  end

  def Boat::dinghy
    Boat.where("length < 20")
  end

  def Boat::ship
    Boat.where("length > 20")
  end

  def Boat::last_three_alphabetically
    Boat.order(name: :desc).limit(3)
  end

  def Boat::without_a_captain
    Boat.where captain_id: nil
  end

  def Boat::sailboats
    includes(:classifications).where(classifications: {name: 'Sailboat'})
  end

  def Boat::with_three_classifications
      joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")
    end

  end


# select name from boats where boat_classifications = 3
# select * from boat where captain_id is nil
# selct name from boats limit 5
# select form boats where "length < 20"
# select * from boats asc limit 3 => Boat.order(:name).first
