class BoatClassification < ActiveRecord::Base
  belongs_to :boat
  belongs_to :classification

  def dinghy
  end

  def ship
  end

  def sailboats
  end
end
