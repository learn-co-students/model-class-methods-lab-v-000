class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats

  def Captain::catamaran_operators
    classification = Classification.where(name: "Catamaran")
    classification[0].captains
  end

  def Captain::sailors
    captains = Boat.sailboats.pluck(:captain_id)
    Captain.where(id: captains)
  end

  def Captain::talented_seamen
    sailcaptains = Captain.sailors.pluck(:id)
    classification = Classification.where(name: "Motorboat")
    motorcaptains = []
    classification[0].captains.each { |c| motorcaptains << c.id}
    allcaptains = []
    sailcaptains.each do |c|
      if motorcaptains.include?(c)
        allcaptains << c
      end
    end
    Captain.where(id: allcaptains)
  end

  def Captain::non_sailors
    allcaptains = []
    sailcaptains = Captain.sailors.pluck(:id)
    Captain.all.each do |c|
      if !sailcaptains.include?(c.id)
        allcaptains << c.id
      end
    end
    Captain.where(id: allcaptains)
  end
end