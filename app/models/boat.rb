class Boat < ActiveRecord::Base

    belongs_to  :captain
    has_many    :boat_classifications
    has_many    :classifications, through: :boat_classifications

    def self.first_five
      limit(5)
    end

    def self.dinghy
      where("length < 20")
    end

    def self.ship
      where("length >= 20")
    end

    def self.last_three_alphabetically
      order(name: :desc).limit(3)
    end

    def self.without_a_captain
      where(captain_id: nil)
    end

    def self.sailboats
      includes(:classifications).where(classifications: {name: "Sailboat"})
    end


  # In the case of a belongs_to relationship, an association key can be used to specify the model if an Active Record object is used as the value. This method works with polymorphic relationships as well.
  #
  # Article.where(author: author)
  # Author.joins(:articles).where(articles: { author: author })
  #so, boats has_many classifications so joins(:classifications) ?
    def self.with_three_classifications

     joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")
    end

    # for use in classification.rb
    def self.longest
      order("length DESC").first
    end

end
