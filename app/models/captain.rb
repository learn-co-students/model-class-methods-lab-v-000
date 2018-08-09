class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.all.each do |captain|
      captain.boats.collect do |boat|
        if boat.classifications.name == "Catamaran"
        boat.captain
      end
      end
    end
  end
end
