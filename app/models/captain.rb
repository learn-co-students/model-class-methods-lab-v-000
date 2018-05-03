class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats

  def self.catamaran_operators 
    Captain.includes(:classifications).where(classifications:{name: 'Catamaran'}).uniq	
    # Captain.joins(:boats).includes(:classifications).where(classifications:{name: 'Catamaran'}).uniq  	
  end 

  def self.sailors
  	Captain.includes(:classifications).where(classifications:{name: 'Sailboat'}).uniq  	
  end 

  def self.talented_seafarers
  	# binding.pry
  	@one = Captain.joins(:classifications).where(classifications:{name: "Sailboat"}).uniq
  	@two = Captain.joins(:classifications).where(classifications:{name: "Motorboat"}).uniq
  	@one.map do |captain| 
  		captain if @two.include(captain)
  	end.uniq
  end 
end
