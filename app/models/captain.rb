class Captain < ActiveRecord::Base
  has_many :boats
<<<<<<< HEAD

  def self.catamaran_operators
    # Solution #1
    #
    # Classification.all.each do |c|
    #   if c.name == "Catamaran"
    #     @catamarans = c.boats
    #   end
    # end
    # @captains = []
    # @catamarans.each do |c|
    #   @captains << c.captain
    # end
    # Captain.where(id: @captains.map(&:id))

    # Solution #2

    Captain.includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end




  def self.sailors
    # Solution #1
    #
    # Classification.all.each do |c|
    #   if c.name == "Sailboat"
    #     @sailboats = c.boats
    #   end
    # end
    # @captains = []
    # @sailboats.each do |s|
    #   @captains << s.captain
    # end
    # @uniq = @captains.uniq.compact
    # Captain.where(id: @uniq.map(&:id))

    # Solution #2
    Captain.includes(boats: :classifications).where('classifications.name = ?', 'Sailboat').uniq

  end

  def self.motorboats
    Captain.includes(boats: :classifications).where('classifications.name = ?', 'Motorboat').uniq
  end

  def self.talented_seamen
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboats.pluck(:id))
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end

=======
>>>>>>> 4971cb53f290a9e7272e339aeb997b5c1f31444a
end
