class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    #returns all captains of catamarans
    includes(:boats => :classifications).group('captains.name').where(:classifications => {:name=>"Catamaran"})
  end

  def self.sailors
    includes(:boats => :classifications).group('captains.name').where(:classifications => {:name=>"Sailboat"})
  end
    #returns captains with sailboats (FAILED - 2)
  
  def self.motorboats
    includes(:boats => :classifications).group('captains.name').where(:classifications => {:name=>"Motorboat"})
  end

  def self.talented_seamen
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboats.pluck(:id))
  end
    #returns captains of motorboats and sailboats (FAILED - 3)
  
  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end
end
