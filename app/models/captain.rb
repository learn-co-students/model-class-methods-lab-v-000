class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats

  def self.catamaran_operators
  	includes(:boats => :classifications).group('captains.name').where(:classifications => {:name=>"Catamaran"})
  end

  def self.sailors
  	includes(:boats => :classifications).group('captains.name').where(:classifications => {:name=>"Sailboat"})
  end

  def self.motorboatists
    includes(:boats => :classifications).group('captains.name').where(:classifications => {:name=>"Motorboat"})
  end  

  def self.talented_seamen
    sailors.where('captains.name in (?)', self.motorboatists.pluck(:name))
  end

  def self.non_sailors
    where('name NOT IN (?)', self.sailors.pluck(:name))
  end
end


#includes(:boats => :classifications).group('captains.name').where('classification.name = "Sailboat"')