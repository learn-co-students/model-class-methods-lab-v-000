class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: :classifications).where(:classifications => { :name => 'Catamaran' }).uniq
  end

  def self.sailors
    joins(boats: :classifications).where(:classifications => { :name => 'Sailboat' }).uniq
  end

  def self.motorboat_captains
    joins(boats: :classifications).where(:classifications => { :name => 'Motorboat' }).uniq
  end

  def self.talented_seafarers
    where(:id => sailors & motorboat_captains)
    
    # (:id => sailors AND motorboat_captains)
    # (:id => [captain1, captain2])
    # (:id => [captain1, captain2].map(&:id))
    # (:id => [1, 2])
    # "WHERE id IN (1, 2)"
    # "WHERE id = 1 AND id = 2"
    # "WHERE id = 1 OR id = 2"
  end

  def self.non_sailors
    where.not(:id => sailors)

    # (:id => sailors)
    # (:id => [captain1, captain2])
    # (:id => [captain1, captain2].map(&:id))
    # (:id => [1, 2])
    # "WHERE id IN (1, 2)"
    # "WHERE id = 1 OR id = 2"
    # "WHERE NOT id = 1 OR id = 2"
  end
end
