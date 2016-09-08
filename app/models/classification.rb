class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    all
  end

  def self.longest
    # joins(:boats).maximum("boats.length")
    # joins(:boats).order("boats.length" => :desc).limit(1)
    # find_by_sql("SELECT * FROM boats
    #   INNER JOIN classifications ON boats.id = classifications.boat_id
    #   ORDER BY boats.created_at desc")
    #   Product.joins(:category).merge(Category.order(priority: :desc))
      joins(:boats).merge(Boat.order(length: :desc)).limit(2)
  end
end
