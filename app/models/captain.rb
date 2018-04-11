class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})

    # captain_ids = Boat.catamarans.collect {|i| i.captain_id}
    # Captain.where(id: captain_ids)
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboaters
    includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seamen
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
    # captain_ids1 = Boat.sailboats.collect {|i| i.captain_id}
    # captain_ids2 = Boat.motorboats.collect {|i| i.captain_id}
    # captain_ids = []
    # captain_ids1.each {|id| captain_ids << id if captain_ids2.include?(id)}
    # captain_ids = captain_ids.uniq!
    # Captain.where(id: captain_ids)
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
    # captain_ids = []
    # Captain.all.each do |i|
    #   if !Captain.sailors.include?(i)
    #     captain_ids << i.id
    #   end
    # end
    # Captain.where(id: captain_ids)
  end
end
