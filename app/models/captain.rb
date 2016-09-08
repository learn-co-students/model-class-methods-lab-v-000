class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # captains have many boats, boats have many classifications 
    # http://stackoverflow.com/questions/16131201/multiple-table-joins-in-rails
    Captain.joins(:boats => :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    Captain.joins(:boats => :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.talented_seamen
    Captain.joins(:boats => :classifications).where(classifications: {name: "Motorboat"}, classifications: {name: "Sailboat"})
    # Captain.joins(:boats => :classifications).where('(classifications.name = ? AND classifications.name = ?)', "Sailboat", "Motorboat")



  end

end



# Category.includes(articles: [{ comments: :guest }, :tags]).find(1)


# Author.joins("INNER JOIN posts ON posts.author_id = authors.id AND posts.published = 't'")
# Person.where("first_name = ? AND last_name = ?", first_name, last_name)