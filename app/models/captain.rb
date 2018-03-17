class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats

    def self.catamaran_operators
      self.joins(:classifications).where(:classifications => {name: "Catamaran"})
    end

    def self.sailors
      self.joins(:classifications).where(:classifications => {name: "Sailboat"}).uniq
    end

    def self.motorboat_drivers
      self.joins(:classifications).where(:classifications => {name: "Motorboat"}).uniq
    end

    def self.talented_seamen
      # where("name IN (?)", Captain.where(:classifications => {name: "Motorboat"}).pluck(:name) & Captain.where(:classifications => {name: "Sailboat"}).pluck(:name))
      where("id IN (?)", Captain.motorboat_drivers.pluck(:id) & Captain.sailors.pluck(:id))
    end

    def self.non_sailors
      where("id NOT IN (?)", Captain.sailors.pluck(:id))
    end



    def self.table
      Captain.arel_table
    end
end
