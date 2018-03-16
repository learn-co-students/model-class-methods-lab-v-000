class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators  	
  	 joins(:boats => :classifications).where('classifications.name' => 'Catamaran')
  end

  def self.sailors  	
  	 joins(:boats => :classifications).where('classifications.name' => 'Sailboat').distinct
  end

  def self.talented_seamen
  	joins(:boats => :classifications).group('classifications.id').having('classifications.name' => ['Sailboat', 'Motorboat'])

  end

  def self.non_sailors
  	where.not("id IN (?)", self.sailors.pluck(:id))

  end





  #Captain::catamaran_operators returns all captains of catamarans
  #Captain::sailors returns captains with sailboats
  #Captain::talented_seamen returns captains of motorboats and sailboats
  #Captain::non_sailors returns people who are not captains of sailboats

end
