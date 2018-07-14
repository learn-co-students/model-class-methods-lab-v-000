class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Boat.joins(:classifications).where(classifications: {name: 'Catamaran'}).select('captain_id')
    binding.pry
  end
  end
