class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  scope :dinghy, -> { where('length < 20') }
  scope :ship, -> { where('length >= 20') }
  scope :without_a_captain, -> { where(captain_id: nil) }


  def self.first_five
    first(5)
  end

  def self.last_three_alphabetically
    order(name: :desc).first(3)
  end

  def self.sailboats
    includes(:classifications).where(classifications: { name: 'Sailboat' })
  end

  def self.with_three_classifications
    joins(:classifications).group('boats.id').having('COUNT(*) = 3')
  end

  def self.longest
    order(length: :desc).first.length
  end
end
