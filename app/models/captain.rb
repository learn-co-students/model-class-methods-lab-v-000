class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    #binding.pry
    captain_ids = []
    Boat.catamarans.each do |boat|
      captain_ids << boat.captain_id
    end
    where("id IN (?)", captain_ids)
  end

end
