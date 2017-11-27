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

  def self.sailors
    #binding.pry
    captain_ids = []
    Boat.sailboats.each do |boat|
      captain_ids << boat.captain_id
    end
    where("id IN (?)", captain_ids)
  end

  def self.talented_seamen
    #binding.pry
    sailboat_ids = []
    motorboat_ids = []
    captain_ids = []
    Boat.sailboats.each do |boat|
      sailboat_ids << boat.captain_id
    end
    Boat.motorboats.each do |boat|
      motorboat_ids << boat.captain_id
    end
    sailboat_ids.each do |id|
      if motorboat_ids.include?(id)
        captain_ids << id
      end
    end
    where("id IN (?)", captain_ids)
  end

end
