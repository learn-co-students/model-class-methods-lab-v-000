class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    select(:name).limit(5)
  end

  def self.dinghy
    select(:name).where("length <?", 20)
  end

  def self.ship
    select(:name).where("length >=?", 20)
  end

  def self.last_three_alphabetically
    select(:name).order(:name => :desc).limit(3)
  end

  def self.without_a_captain
    select(:name).where("captain_id" => nil)
  end

  def self.sailboats
    includes(:classifications).where('classification_id = ?', find_classification("Sailboat").id)
  end

  def self.with_three_classifications
    joins(:classifications).group('boats.id').having("COUNT(*) = 3")
  end

  private

  def self.find_classification(type)
    Classification.find_by(name: type)
  end

end
