class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  #model methods perform business logic (helper methods perform presentation logic like formatting datetime)
  def self.first_five
        all.limit(5)
        #could also be written as
        #limit.(5)
  end
  def self.dinghy
#binding.pry
        where("length <?", 20)
        #could also be written as
        #where("length < 20")
  end
  def self.ship
#binding.pry
        where("length >=?", 20)
        #could also be written as
        #where("length >= 20")
  end
  def self.last_three_alphabetically
#binding.pry
        all.order(name: :desc).limit(3)
        #coulde also be written as
        #order(name: :desc).limit(3)
        #or
        #order("name DESC").limit(3)

  end
  def self.without_a_captain
    #binding.pry
        where(captain_id: nil)
  end
  def self.sailboats
      #Boat has many classifications and classifications have many boats, they are connected through a joins table boat_classifications
#        binding.pry
        includes(:classifications).where(classifications: {name: "Sailboat"})
  end
  def self.with_three_classifications
#binding.pry
      joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")

#lets count everything in the joins table
      #joins(:classifications).count
      # => 26
            #BoatClassification.count
            # => 26
#for every boat count how many classifications
      #joins(:classifications).group("boats.id").count
            # => {1993=>2,
            # => 1994=>3,
            # => 1995=>2,
            # => 1996=>3,
            # => 1997=>1,
            # => 1998=>2,
            # => 1999=>2,
            # => 2000=>2,
            # => 2001=>2,
            # => 2002=>3,
            # => 2003=>2,
            # => 2004=>2}
                    #Boat.find(1993).classifications.count
                    # => 2
#find and yield boats that have 3 classifications
      #joins(:classifications).group("boats.id").having("COUNT(*) = 3")
            # => [#<Boat:0x00000004519380
            # =>      id: 1994,
            # =>      name: "Nacra 17",
            # =>      length: 17,
            # =>      captain_id: 998,
            # =>      created_at: Mon, 12 Mar 2018 02:20:56 UTC +00:00,
            # =>      updated_at: Mon, 12 Mar 2018 02:20:57 UTC +00:00>,
            # => #<Boat:0x00000004519128
            # =>      id: 1996,
            # =>      name: "Zodiac CZ7",
            # =>      length: 24,
            # =>      captain_id: 1000,
            # =>      created_at: Mon, 12 Mar 2018 02:20:56 UTC +00:00,
            # =>      updated_at: Mon, 12 Mar 2018 02:20:57 UTC +00:00>,
            # => #<Boat:0x00000004518e80
            # =>      id: 2002,
            # =>      name: "Sun Tracker Regency 254 XP3",
            # =>      length: 27,
            # =>      captain_id: 1002,
            # =>      created_at: Mon, 12 Mar 2018 02:20:57 UTC +00:00,
            # =>      updated_at: Mon, 12 Mar 2018 02:20:58 UTC +00:00>]
  end
  def self.longest
      order('length DESC').first
      #order(name: :desc).first
  end
  def self.non_sailboats
      where("id NOT IN (?)", self.sailboats.pluck(:id))
  end

end
