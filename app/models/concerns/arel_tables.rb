module ArelTables
  def captains_arel
    Captain.arel_table
  end

  def boats_arel
    Boat.arel_table
  end

  def classifications_arel
    Classification.arel_table
  end
end