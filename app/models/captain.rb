class Captain < ActiveRecord::Base
  has_many :boats


    def self.catamaran_operators
      joins(boats: :classifications).where(classifications: {name: 'Catamaran'})
    end

    def self.sailors
      joins(boats: :classifications).where(classifications: {name: 'Sailboat'}).distinct
    end

   def self.non_sailors
     Captain.where.not(id: sailors.pluck(:captain_id))
   end


  def self.talented_seamen
    Captain.joins(boats: :classifications)
      .joins('INNER JOIN "boats" b ON b."captain_id" = "captains"."id"
              INNER JOIN "boat_classifications" bc ON bc.boat_id = b.id
              INNER JOIN "classifications" c ON c.id = bc.classification_id')
      .where(classifications: {name: 'Sailboat'}, c: { name: 'Motorboat' }).distinct

    Captain.where(id: Boat.joins(:classifications).where(classifications: {name: "Sailboat"}).select(:captain_id))
            .where(id: Boat.joins(:classifications).where(classifications: {name: "Motorboat"}).select(:captain_id))


    %w(Sailboat Motorboat).inject(self) do |rel, name|
      rel.where(id: Boat.joins(:classifications).where(classifications: {name: name}).select(:captain_id))
    end

  end

end
