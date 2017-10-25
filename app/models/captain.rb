class Captain < ActiveRecord::Base
  has_many :boats


  def self.catamaran_operators
    Captain.joins(boats: :classifications).where('classifications.name = ?', "Catamaran")
  end

  def self.sailors
    Captain.joins(boats: :classifications).where('classifications.name = ?', "Sailboat").distinct
  end

  def self.motorboaters
    Captain.joins(boats: :classifications).where('classifications.name = ?', "Motorboat").distinct
  end

  def self.talented_seamen
   sailor_names = self.sailors.collect {|sailor| sailor.name}

   self.joins(:boats => :classifications).where('classifications.name' => 'Motorboat').where('captains.name' => sailor_names)
  end

  def self.non_sailors
    # sailor_names = self.sailors.collect {|sailor| sailor.name}
    #
    # self.joins(:boats => :classifications).where('classifications.name' => 'Motorboat').where.not('captains.name IN'=>   sailor_names).

    self.where.not("id IN (?)", self.sailors.pluck(:id))
  end

end
