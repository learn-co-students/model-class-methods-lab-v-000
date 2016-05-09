class Captain < ActiveRecord::Base
  has_many :boats


  def self.catamaran_operators
    joins(boats: :classifications).where(:classifications => {:name => "Catamaran"})
  end

  def self.sailors
    joins(boats: :classifications).where("classifications.name" => "Sailboat").distinct
  end

  def self.talented_seamen
    where("classifications.name" => "Sailboat")
  end
end
