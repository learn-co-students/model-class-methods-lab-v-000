class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.includes(:boats => :classifications).where(:classifications => {:name => "Catamaran"})
  end

  def self.sailors
    self.includes(:boats => :classifications).where(:classifications => {:name => "Sailboat"}).uniq
  end

  def self.talented_seamen
binding.pry
    self.includes(:boats => :classifications).where(:classifications => {:name => "Sailboat"}).uniq.or.self.includes(:boats => :classifications).where(:classifications => {:name => "Motorboat"}).uniq
  end
end
