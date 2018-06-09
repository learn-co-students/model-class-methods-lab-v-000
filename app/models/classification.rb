class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

#   rspec ./spec/models/classification_spec.rb:5 # Classification::my_all returns all classifications
# rspec ./spec/models/classification_spec.rb:12 # Classification#longest returns the classifications for the longest boat
# what's the difference between :: and # here? are they both accepted ways to note methods?
  def self.my_all 
    self.all
  end
#  would  we do this in real life, not  calling a specific method for an attribute (:name)? or just following the test
  def self.longest
    Boat.longest.classifications
    # WHy does this work with order("length DESC").first and not "order(length: :desc).limit(1)" with Boat#longest?
        #SEPARATION OF CONCERNS!!!
  end
end