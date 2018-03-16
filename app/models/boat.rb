class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications


  private

  def self.first_five
    Boat.limit(5)
  end

  def self.dinghy
    Boat.where("length < ?", 20)
  end

  def self.ship
    where("length >= ?", 20)
  end

  def self.last_three_alphabetically
    Boat.order('name desc').limit(3)
  end

  def self.without_a_captain
    where(captain_id: nil)
  end

  def self.sailboats
     includes(:classifications).where(classifications: { name: 'Sailboat' })
  end

  def self.with_three_classifications
    joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")
  end

def method_name
   includes(:classifications).where(classifications: { name: 'Sailboat' }).where(classifications: { name: 'Motorboat' })

# Client.where("name = ? AND locked = ?", params[:orders], false)

end

  def self.longest
    order('length DESC').first
  end


end
