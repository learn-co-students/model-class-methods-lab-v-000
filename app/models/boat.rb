class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications
  def self.first_five
    self.limit(5)
  end

  def self.dinghy
    self.where("length <?", 20)
  end
  def self.ship
    self.where("length >=?", 20)
  end

  def self.last_three_alphabetically
    self.all.order("name DESC").limit(3)
  end

  def self.without_a_captain
    self.where(captain: nil)
  end

  def self.sailboats
    self.joins(:classifications).where(classifications: {name: "Sailboat"})
  end

  def self.with_three_classifications
    # binding.pry
    Boat.joins(:classifications).group('boats.id').having('count(boat_id) == 3')
    # Project.joins(:vacancies).group('projects.id').having('count(project_id) > 1')
    #
    # BoatClassification.group(:boat_id)
    # Boat.joins(:boat_classifications).where(boat_classifications: {boat_id: })
    # Boat.joins(:boat_classifications).select(:boat_id).group(:boat_id).having()
    # Account.joins(:users).select('accounts.id').group('accounts.id').having('count(users.id) > 1')

  end
end
