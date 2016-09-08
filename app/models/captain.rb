class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(:boats => :classifications).where("classifications.name" => "Catamaran")
  end

  def self.sailors
    joins(:boats => :classifications).where("classifications.name" => "Sailboat").distinct
  end

  def self.talented_seamen
    skippers = self.joins(:boats => :classifications).where("classifications.name" => "Motorboat")
    sailors  = self.joins(:boats => :classifications).where("classifications.name" => "Sailboat")
    from("(#{sailors.to_sql} INTERSECT #{skippers.to_sql}) AS captains")
  end

  def self.non_sailors
    sailors  = self.joins(:boats => :classifications).where("classifications.name" => "Sailboat")
    from("(#{self.all.to_sql} EXCEPT #{sailors.to_sql}) AS captains")
  end

end
