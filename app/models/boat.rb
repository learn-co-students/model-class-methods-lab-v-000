require 'pry'
class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.all.limit(5)
  end

  def self.dinghy
    self.all.where("length < ?", 20)
  end

  def self.ship
    self.all.where("length >= ?", 20)
  end

  def self.last_three_alphabetically
    self.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    #captain_id is null OR blank
    self.where(captain_id: [nil, ""])
  end

  def self.sailboats
    self.includes(:classifications).where(classifications: {name: 'Sailboat'})
  end

  def self.with_three_classifications
    #1. joins table on args(:classification)
    #2. .group => group by attribute(boats.id)
    #3. .having => (boat.id that has 3 or more classifications)
    #4. .select("boats.*") => all boats from this group
    self.joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")
  end

  def self.longest
    #orderby length, descending, take first
    order('length DESC').first
  end
end
