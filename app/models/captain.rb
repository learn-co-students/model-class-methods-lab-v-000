class Captain < ActiveRecord::Base
  has_many :boats

#returns all captains of catamarans
  def catamaran_operators

  end

#returns captains with sailboats
  def sailors

  end

#returns captains of motorboats and sailboats
  def talented_seafarers

  end

#returns people who are not captains of sailboats
  def non_sailors

  end
end
