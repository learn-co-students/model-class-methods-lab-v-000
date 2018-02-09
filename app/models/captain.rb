class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    @boats_captain_ids = Boat.joins(:classifications).where(:classifications => {name: 'Catamaran'}).pluck(:captain_id)
    self.where(id: @boats_captain_ids)
  end

  def self.sailors
    @boats_captain_ids = Boat.joins(:classifications).where(:classifications => {name: 'Sailboat'}).pluck(:captain_id)
    self.where(id: @boats_captain_ids)
  end

  def self.talented_seamen
    @boats_captain_ids_sailboat = Boat.joins(:classifications).where(:classifications => {name: 'Sailboat'}).pluck(:captain_id)
    @boats_captain_ids_motorboat = Boat.joins(:classifications).where(:classifications => {name: 'Motorboat'} ).pluck(:captain_id)
    @boats_captain_ids = @boats_captain_ids_sailboat & @boats_captain_ids_motorboat
    self.where(id: @boats_captain_ids)
  end

  def self.non_sailors
    @boats_captain_ids = Boat.joins(:classifications).where(:classifications => {name: 'Sailboat'}).pluck(:captain_id)
    self.where.not(id: @boats_captain_ids)
  end
end
