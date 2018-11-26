require 'pry'
class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Captain.joins(boats: :classifications).group('captain_id').where(classifications: {name: ["Catamaran"]})
  end
end
