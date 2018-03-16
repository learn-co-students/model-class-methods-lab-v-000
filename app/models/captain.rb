class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: [{ boat_classifications: :classification }]).where('classifications.name = "Catamaran"')
  end

  def self.sailors
    self.joins(boats: [{ boat_classifications: :classification }]).where('classifications.name = "Sailboat"').uniq
  end

  def self.talented_seamen
    # collects the ids of the sailors
    sailor_ids = self.sailors.collect { |s| s.id }
    # constructs a query to select all boats classified as Motorboats
    # whose captain is also a sailor.  Checks for each captain and
    # joins the query together with 'or', allowing it to return all
    # captains who captain boats classified as a 'Sailboat' or
    # a 'Motorboat'
    query = sailor_ids.collect do |sailor_id|
      "(captains.id = #{sailor_id} and classifications.name = 'Motorboat')"
    end.join(" or ")
    self.joins(boats: [{ boat_classifications: :classification }]).where(query)
  end

  def self.non_sailors
    sailor_ids = self.sailors.collect { |s| s.id }
    # constructs a query to filter out captains who are
    # classified as Sailors
    query = sailor_ids.collect do |sailor_id|
      "(captains.id = #{sailor_id})"
    end.join(" or ")
    self.where.not(query)
  end
  
end
