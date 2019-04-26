class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    where(:id => Classification.find_by(:name => "Catamaran").boats.map(&:captain_id))
  end

  def self.sailors
    where(:id => Classification.find_by(:name => "Sailboat").boats.map(&:captain_id))
  end

  def self.motorboat_operators
    where(:id => Classification.find_by(:name => "Motorboat").boats.map(&:captain_id))
  end

  def self.talented_seafarers
    captain_ids = Captain.all.select do |cap|
      self.motorboat_operators.pluck(:name).include?(cap.name) && self.sailors.pluck(:name).include?(cap.name)
    end.map(&:id)

    where(:id => captain_ids)
  end

  def self.non_sailors
    sailor_ids = self.sailors.pluck(:id)
    where.not(:id => sailor_ids)
  end
end
