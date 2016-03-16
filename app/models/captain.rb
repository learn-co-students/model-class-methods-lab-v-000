class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats

  def self.catamaran_operators
  	joins(:boats => :classifications).where('classifications.name = "Catamaran"').uniq
  end

  def self.sailors
  	joins(:boats => :classifications).where('classifications.name = "Sailboat"').uniq
  end

  def self.motorists
  	joins(:boats => :classifications).where('classifications.name = "Motorboat"').uniq
  end

  def self.talented_seamen
  	seaman_ids = sailors.pluck(:id) & motorists.pluck(:id) 
    self.where("id in (?)", seaman_ids)	
  end

  def self.non_sailors
  	where.not("id in (?)", sailors.pluck(:id))
  end

end
