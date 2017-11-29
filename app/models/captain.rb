class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    captain_by_classification('Catamaran')
  end

  def self.sailors
    captain_by_classification('Sailboat')
  end

  def self.talented_seamen
    #filter with OR
    #then select captains with 2 or more unique classification names
    self.where(id: Classification.captain_id_join.group(:captain_id).having("count(DISTINCT classifications.name) >= 2").where(['classifications.name = ? OR classifications.name = ?', "Sailboat","Motorboat"]))
  end

  def self.non_sailors
    #try double where clause
    # self.where(id: Classification.captain_id_join.group(:captain_id).having("count(DISTINCT classifications.name) >= 2").where.not(['classifications.name = ?', "Sailboat"]))
    # Classification.captain_id_join.group(:captain_id).having("classifications.name != 'Sailboat'")
  end

  private

  def self.captain_by_classification(classification_name)
    self.where(id: Boat.joins(:classifications).select(:captain_id).where(["classifications.name = ?", classification_name]))
  end

end
