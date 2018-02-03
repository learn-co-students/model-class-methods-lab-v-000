class Captain < ActiveRecord::Base
  has_many :boats

  class << self

    def catamaran_operators
    end
  end
end
