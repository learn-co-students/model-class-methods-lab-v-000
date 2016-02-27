class Captain < ActiveRecord::Base
  has_many :boats


  def self.catamaran_operators
    arr = Classification.find_by(name: "Catamaran").boats.map {|f| f.captain}
    self.where(id: arr.map(&:id))
  end

  def self.sailors
    arr = Classification.find_by(name: "Sailboat").boats.map {|boat| boat.captain}.compact
    self.where(id: arr.map(&:id))

  end

  def self.talented_seamen
    sail_arr = Classification.find_by(name: "Sailboat").boats.map {|boat| boat.captain}.compact
    motor_arr = Classification.find_by(name: "Motorboat").boats.map {|boat| boat.captain}.compact

    arr = sail_arr & motor_arr
    self.where(id: arr.map(&:id))
  end

  def self.non_sailors
    sailors = Captain.sailors
    arr = Captain.all - Captain.sailors
    self.where(id: arr.map(&:id))
  end
  
end
