class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.select_classifications(classification)
    find_by(:name => classification)
  end
end
