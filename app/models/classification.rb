class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.sailboats
    all.where(name: 'Sailboat')
  end
end
