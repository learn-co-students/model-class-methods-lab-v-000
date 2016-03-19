class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Captain.all.joins(boats: :classifications).where(:classifications => {:name => "Catamaran"})
  end

  def self.sailors
    Captain.all.joins(boats: :classifications).where(:classifications => {:name => "Sailboat"}).uniq
  end

  def self.talented_seamen
    motorboaters_ids = Captain.all.joins(boats: :classifications).where(
      :classifications => {:name => "Sailboat"}).pluck(:id).uniq

    sailboaters_ids = Captain.all.joins(boats: :classifications).where(
      :classifications => {:name => "Motorboat"}).pluck(:id).uniq


    Captain.all.where("id in (?)", motorboaters_ids & sailboaters_ids)
  end

  def self.non_sailors
    Captain.all.where.not("id in (?)", Captain.sailors.pluck(:id) )
  end
end
