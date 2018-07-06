class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    select(id: true)
  end

  def self.longest
    select(:classification).order(:length).last
  end
  
end
