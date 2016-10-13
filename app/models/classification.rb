class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications
  def self.my_all
      select(:classifications)
    end

    def self.longest ## need to figure this one out
      Boat.order(length: :desc).first.classifications
    end
  end
