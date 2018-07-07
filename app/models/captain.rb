class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    catamaran_class = Classification.find_by(:name => "Catamaran")
    Captain.joins(:boats).where('classification_id = ?', catamaran_class.id)
  end

end
