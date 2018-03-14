class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
	# Captain::catamaran_operators returns all captains of catamarans
	includes(boats: :classifications).where(classifications: {name: 'Catamaran'})
  end

  def self.sailors
	# Captain::sailors returns captains with sailboats
  	includes(boats: :classifications).where(classifications: {name: 'Sailboat'}).uniq
  end

  def self.motorboat_operators
	# Captain::sailors returns captains with sailboats
  	includes(boats: :classifications).where(classifications: {name: 'Motorboat'}).uniq
  end

  def self.talented_seafarers
	# Captain::talented_seafarers returns captains of motorboats and sailboats
	where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
	# includes(boats: :classifications).where(classification[:name].eq('Motorboat').and(
  end

  def self.non_sailors
	# Captain::non_sailors returns people who are not captains of sailboats
	where.not("id IN (?)", self.sailors.pluck(:id))
  end
end
