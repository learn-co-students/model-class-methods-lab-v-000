class Captain < ActiveRecord::Base
  has_many :boats


  def self.catamaran_operators
    joins(boats: :classifications).where("classification_id == ? ", 3).uniq
  end

  def self.sailors
    joins(boats: :classifications).where("classification_id == ? ", 2).uniq
  end

  def self.motordudes
    joins(boats: :classifications).where("classification_id == ? ", 5).uniq
  end

  def self.talented_seamen
    arr = self.sailors.pluck(:id) & self.motordudes.pluck(:id)
    where(id: arr)
  end

  def self.non_sailors
    #how about all captains not included in self.sailors
    where.not(id: self.sailors.pluck(:id))
  end


end
