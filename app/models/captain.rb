class Captain < ActiveRecord::Base
  has_many :boats

  class << self

    def catamaran_operators
      # Boat.joins(:classifications).where("classifications.name = 'Catamaran'").map { |boat| boat.captain.name }
      includes(boats: :classifications).where(classifications: {name: "Catamaran"}).uniq
    end

    def sailors
      includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
    end

    def motorboat_operators
      includes(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
    end

    def talented_seamen
      ids = sailors.pluck(:id) & motorboat_operators.pluck(:id)
      where("id IN (?)", ids)
    end

    def non_sailors
      where.not("id IN (?)", sailors.pluck(:id))
    end

  end
end
