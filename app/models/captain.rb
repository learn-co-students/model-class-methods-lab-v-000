class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.all.select do |captain|
      captain.boats.each do |boat|
        boat.classifications.find_by(name: 'Catamaran')
      end
    end
  end

  def self.sailors

  end

end
