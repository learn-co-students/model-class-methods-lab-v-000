class Captain < ActiveRecord::Base
  has_many :boats

  def catamaran_operators

  end

  def self.non_sailors
      Boat.where('captain_id != ?', [nil,""]).each do
      end
    end

end
