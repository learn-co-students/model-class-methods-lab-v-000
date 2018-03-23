class Captain < ActiveRecord::Base
# t.string  :name
# t.boolean :admiral
  has_many :boats

# returns all captains of catamarans
  def self.catamaran_operators
    Captain.where(id: Classification.where(:name => "Catamaran").first.boats.pluck(:captain_id))
  end

# returns captains with sailboats
  def self.sailors
    Captain.where(id: Classification.where(:name => "Sailboat").first.boats.pluck(:captain_id))
  end

# returns captains of motorboats and sailboats
  def self.talented_seafarers
    sailboatID = Classification.find_by(:name => 'Sailboat').id
    motorboatID = Classification.find_by(:name => 'Motorboat').id

    sailboats = Boat.all.select do |boat|
      boat.classifications.pluck(:id).include?(sailboatID)
    end
    motorboats = Boat.all.select do |boat|
      boat.classifications.pluck(:id).include?(motorboatID)
    end

    sailboatCaptains = sailboats.collect {|boat| boat.captain}.uniq
    motorboatCaptains = motorboats.collect {|boat| boat.captain}.uniq

    Captain.where(id: (sailboatCaptains & motorboatCaptains).map(&:id))
  end

# returns people who are not captains of sailboats
  def self.non_sailors
    Captain.where.not(id: Classification.where(:name => "Sailboat").first.boats.pluck(:captain_id))
  end
end
