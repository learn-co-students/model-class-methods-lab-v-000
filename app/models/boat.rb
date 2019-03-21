class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications


  def self.first_five
    # binding.pry
    # self.all[0..4]
    self.limit(5)
    # binding.pry
  end

  def self.dinghy
    # binding.pry
    # i want to grab all boats with a length less than 20. i'll return it as an array
    # which they will check with pluck to grab the names with.
    # i could
      # find a method that does exactly what i need- which is to extract the relevant objects
      # myself write code to establish a collection, comb it (select)

    # self.where(length: < 20)
      # self.select{|boat| boat.length < 20}
    # select works by going over a series of ruby objects that represenet database stuff.
     # but it sounds like limit and pluck work on the databse more directly, or at least thjrough
     # interacting with SQL which itself queries the database directly. Also
# binding.pry
      self.where("length < '20' ")
    # this worked because...i think where is also a query method for active record. actually so it
    # select. but i think it works with the databse more directly.

  end

  def self.ship
    self.where("length >= '20' ")
  end

  def self.last_three_alphabetically
    # self.includes( :boat ).order('name DESC')
    self.order(name: :desc).limit(3)
    # binding.pry
    # don't think i can use an array, if i can't convert it
    # so it has to be done with stuff like where and limit
    #i have to alphabetize the collection with where? then pick the last three

  end

  # def without_a_captain
  #   # self.includes.where("captain_id" = nil)
  #   self.where("captain_id = 'nil' ")
  #
  # end

# returns nil. might be not returning an array
# what does find.each return
# it might be either not working and combing through the objects and assembling them
# into a new collection array or otherwise.
# if so is there a method like find_all
  # def self.without_a_captain

  #   @result = self.find_each do |boat|
  #     boat.captain_id == nil

  #
  #   end
  #   @result

  # end

  def self.without_a_captain
    # binding.pry
    self.where(captain_id: nil)
    # binding.pry
  end

# how do you know if a boat is a sailboat
  def self.sailboats
    # binding.pry
    # self.where(classifications: "sailboat")
    # can try to make a loop that cycles through each boat instance,
    # checking its classification instances to see if each has a name of "sailboat".
    # not sure how to do that with .where, but maybe .find_each can do it
    # self.classifications.each do |classification|
    #   classification.name == "sailboat"
    # end
    # self.joins(:classifications).where(name: "sailboat")

    # self.joins(:classifications).first.classifications.find_each do |classification|
    #   classification["name"] == "Sailboat"
    #
    # end
    # binding.pry
    #
    # binding.pry
    # takeaway is first that classifications, we go there from self.includes. but once
    # you're in there, grab from within the classifications object where the name attribute
    # is equal to sailboat with a capital s. The cap thing can only be found by looking
  # at the rspec test itself, some tests just relate to what they're asking for specifically.
    self.includes(:classifications).where(classifications: {name: "Sailboat"})
    # binding.pry

  end



  def self.with_three_classifications
    # can use self.where(active: true) but with classifications.count = 3?
    # an if-then
    # binding.pry
    # self.includes(:classifications).where(classifications.count = 3)
    # self.includes(:classifications).first.classifications.count = 3

    # have to count how many classificaiton objects are associated with each boat
    # self.includes(:classifications).where(classifications.count = 3)
    # @resp = self.all.find_each do |boat|
    #   if boat.classifications.count == 3
    #     boat
    #   end
    #
    # end
# binding.pry
    #
    # self.includes(:classifications).where("classifications.size" = "3")
    # self.joins(:classifications).select {|boat| boat.classifications.size == 3}
    self.joins(:classifications).group("boats.id").having("COUNT(*) = 3")


    # binding.pry
    # how can i add code? i want to count
  end

  def self.longest
    # a = Boat.maximum('length')
    self.order(length: :desc)[0]

  end


  # self.where(active: true).pluck(:id)


end
