class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(:boats => :classifications).where(:classifications => {:name => "Catamaran"})
  end

  def self.sailors
    joins(:boats => :classifications).where(:classifications => {:name => "Sailboat"}).uniq
  end

  def self.motorboat_captains
    joins(:boats => :classifications).where(:classifications => {:name => "Motorboat"}).uniq
  end

  def self.talented_seamen
    where("NAME in (?)", self.sailors.pluck(:name) & self.motorboat_captains.pluck(:name))
    # http://stackoverflow.com/questions/10289522/multiple-or-conditions-in-activerecord
  end

  def self.non_sailors
    where("NAME not in (?)", self.sailors.pluck(:name))
  end

end
