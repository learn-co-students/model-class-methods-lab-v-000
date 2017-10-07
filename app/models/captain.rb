class Captain < ActiveRecord::Base
  has_many :boats
  has_many :boat_classifications, through: :boats
  has_many :classifications, through: :boat_classifications

  def self.catamaran_operators
    joins(:boats, :boat_classifications, :classifications).where('classifications.name = ?', 'Catamaran').distinct
  end

  def self.sailors
    joins(:boats, :boat_classifications, :classifications).where('classifications.name = ?', 'Sailboat').distinct
  end

  def self.talented_seamen
    sailors = joins(:boats, :boat_classifications, :classifications).where('classifications.name = ?', 'Sailboat').distinct
    motorers = joins(:boats, :boat_classifications, :classifications).where('classifications.name = ?', 'Motorboat').distinct
    intersection = sailors & motorers
    intersection.map {|i| i.name }
  end

  # def self.talented_seamen
  #   connection.execute(<<-SQL
  #     SELECT
  #       cap.name,
  #       (
  #         SELECT GROUP_CONCAT(classifications.name)
  #         from boats
  #          inner join boat_classifications ON boat_classifications.boat_id = boats.id
  #          inner join classifications ON classifications.id = boat_classifications.id
  #        WHERE 1=1
  #         AND boats.captain_id = cap.id
  #      ) AS classifications
  #     FROM captains cap
  #     WHERE 1=1
  #       AND classifications LIKE '%Sailboat%'
  #       AND classifications LIKE '%Motorboat%'
  #   SQL
  #   ).map { |captain| captain["name"] }
  # end

  def self.non_sailors
    sailors = joins(:boats, :boat_classifications, :classifications).where('classifications.name = ?', 'Sailboat')
    (all - sailors).map { |i| i.name }
  end

end
