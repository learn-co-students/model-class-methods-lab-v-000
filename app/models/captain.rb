class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(:boats => :classifications).distinct.where("classifications.name" => "Catamaran")
  end

  def self.sailors
    self.joins(:boats => :classifications).distinct.where("classifications.name" => "Sailboat")
  end

  def self.talented_seamen
    sailor_names = self.sailors.collect {|sailor| sailor.name}

    self.joins(:boats => :classifications).where('classifications.name' => 'Motorboat').where('captains.name' => sailor_names)
  end

  def self.non_sailors
    sailor_names = self.sailors.collect {|sailor| sailor.name}

    self.joins(:boats => :classifications).distinct.where.not('captains.name' => sailor_names)
  end

end
