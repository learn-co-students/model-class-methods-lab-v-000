class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: :classifications).where(classifications: {:name => 'Catamaran'})
  end

  def self.sailors
    joins(boats: :classifications).where(classifications: {:name => 'Sailboat'}).uniq
  end

  def self.motorboaters
    joins(boats: :classifications).where(classifications: {:name => 'Motorboat'}).uniq
  end

  def self.talented_seamen
    where(id: [self.motorboaters.pluck(:id).flatten & self.sailors.pluck(:id).flatten])
  end

  def self.non_sailors
      where.not(id: self.sailors.pluck(:id))
  end
          
             

#       Category.joins(articles: [{ comments: :guest }, :tags])
# This produces:

# SELECT categories.* FROM categories
#   INNER JOIN articles ON articles.category_id = categories.id
#   INNER JOIN comments ON comments.article_id = articles.id
#   INNER JOIN guests ON guests.comment_id = comments.id
#   INNER JOIN tags ON tags.article_id = articles.id


#   end
# SELECT captain.* FROM captains
# INNER JOIN boats
# ON boats.captain_id = captain.id
# INNER JOIN boat_classifications
# ON boat_classifications.boat_id = boat.id
# INNER JOIN classifications
# ON boat_classifications.classification_id = classification.id
# WHERE classification.name = ALL (SELECT * FROM classifications WHERE classification.name = "Sailboat" AND classification.name = "Motorboat");

end
