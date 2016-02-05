class Captain < ActiveRecord::Base
  has_many :boats

  #Captain::catamaran_operators returns all captains of catamarans
  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  #Captain::sailors returns captains with sailboats
  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboaters
    includes(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
  end

  #Captain::talented_seamen returns captains of motorboats and sailboats
  def self.talented_seamen
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id)) #gets all the ids of captains with sailboats AND motorboats
  end

  #Captain::non_sailors returns people who are not captains of sailboats
  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id)) #gets all the ids of captains with sailboats, and specifies NOT those ids
  end

end
