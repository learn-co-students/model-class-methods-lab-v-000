class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    catamaran_id = Classification.find_by(name: 'Catamaran').id
    Captain.joins(boats: {boat_classifications: :boat}).where('boat_classifications.classification_id = ?', catamaran_id)
  end

  def self.sailors
    sailboat_id = Classification.find_by(name: 'Sailboat').id
    Captain.joins(boats: {boat_classifications: :boat}).where('boat_classifications.classification_id = ?', sailboat_id).distinct
  end

  def self.motorboaters
    motorboat_id = Classification.find_by(name: 'Motorboat').id
    Captain.joins(boats: {boat_classifications: :boat}).where('boat_classifications.classification_id = ?', motorboat_id).distinct
  end

  def self.talented_seamen
    sailor_ids = Captain.sailors.pluck(:id)
    motorboater_ids = Captain.motorboaters.pluck(:id)
    talented_ids = sailor_ids & motorboater_ids
    Captain.where('id IN (?)', talented_ids)
  end

  def self.non_sailors
    sailor_ids = Captain.sailors.pluck(:id)
    Captain.where.not('id IN (?)', sailor_ids)
  end

end
