class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

  def self.longest
    self.longest_boat
  end

  private
    def self.longest_boat
      joins(boat_classifications:[:boat]).order('length DESC').order('length DESC').group(:length).having(table[:length].maximum)
      # self.table.having(table[:length].maximum)
    end

    def self.table
      Boat.arel_table
    end

end
