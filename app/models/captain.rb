class Captain < ActiveRecord::Base
  has_many :boats

  class << self

    def catamaran_operators
      includes(boats: [:classifications]).where(classifications: {name: "Catamaran"})
    end

    def sailors
      includes(boats: [:classifications]).where(classifications: {name: "Sailboat"}).uniq
    end

    def motorboaters
      includes(boats: [:classifications]).where(classifications: {name: "Motorboat"}).uniq
    end

    def talented_seamen
      sailor_ids = sailors.pluck(:id)
      motorboater_ids = motorboaters.pluck(:id)
      where(id: sailor_ids & motorboater_ids)
    end

    def non_sailors
      sailor_ids = sailors.pluck(:id)
      where.not(id: sailor_ids)
    end
  end
end
