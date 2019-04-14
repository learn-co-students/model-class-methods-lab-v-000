class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.take(5)
  end

  def self.dinghy
    self.where(self.arel_table[:length].lt(20))
  end

  def self.ship
    self.where(self.arel_table[:length].gt(20))
  end

  def self.last_three_alphabetically
    self.limit(3).order('name desc')
  end

  def self.without_a_captain
    self.where(captain: nil)
  end

  def self.sailboats
    #binding.pry
    self.joins(:classifications).where(:classifications => {:name => "Sailboat"})

  end

  def self.with_three_classifications
    b = Boat.all
    d = []
    b.each do |c|
      if c.classifications.count >= 3
        d << c
      end
    end
    d
  end

  def self.longest
    order('length desc').first
  end
end
