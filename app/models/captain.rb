class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # joins(:classifications).where(:classifications => {:name => "Catamaran"})
    includes(boats: :classifications).where(classifications: {:name => "Catamaran"})

  end

end
