class Captain < ActiveRecord::Base
  has_many :boats

  def catamaran_operators
    Captain.joins(boats: :classifications)
  end
end
