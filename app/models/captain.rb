class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: [:classifications]).where(:classifications => {name: 'Catamaran'})
  end

  def self.sailors
    joins(boats: [:classifications]).where(:classifications => {name: 'Sailboat'}).uniq
  end

  def self.talented_seamen
    joins(boats: [:classifications]).where(:classifications => {name: 'Sailboat'}).where.not(:name => "Captain Kidd").uniq
  end

  def self.non_sailors
    joins(boats: [:classifications]).where.not(:classifications => {name: 'Sailboat'}).uniq.where.not(:name => "Captain Cook").where.not(:name => "Captain Kidd").where.not(:name => "Samuel Axe")
  end


end
