class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # puts "catamaran_operators"
    # Captain.all.each do |c|
    #   puts "Captain = name: #{c.name} || admiral?: #{c.admiral}"
    #   c.boats.each do |b|
    #     puts "Captain Boat = #{b.name}"
    #     b.classifications.each do |cl|
    #       puts "Boat Classification = #{cl.name}"
    #     end
    #   end
    # end

    Captain.joins(boats: :classifications).where(classifications: { name: "Catamaran" })
  end

  def self.sailors
    # puts "sailors"
    Captain.joins(boats: :classifications).where(classifications: { name: "Sailboat" }).distinct
  end

  def self.talented_seafarers
    puts "talented_seafarers"

    # expected: ["Captain Cook", "Samuel Axe"]
    #      got: ["Captain Cook", "Captain Kidd", "William Kyd", "Arel English", "Henry Hudson", "Samuel Axe"]
    Captain.joins(boats: :classifications).where(classifications: { name: ["Sailboat", "Motorboat"] }).distinct
    # Captain.joins(boats: :classifications).where('classifications.name = ? AND classifications.name = ?', "Sailboat", "Motorboat")
    # Captain.joins(boats: :classifications).select("*").group("captains.name, boats.id").having("classifications.name = ? AND classifications.name = ?", "Sailboat", "Motorboat")
  end

  def self.non_sailors
    puts "non_sailors"
    Captain.all.each do |c|
      puts "Captain = name: #{c.name} || admiral?: #{c.admiral}"
      c.boats.each do |b|
        puts "  Boat = #{b.name}"
        b.classifications.each do |cl|
          if cl.name == "Sailboat" || cl.name == "Motorboat"
            puts "    Classification = #{cl.name}"
          end
        end
      end
    end
    # expected: ["William Kyd", "Arel English", "Henry Hudson"]
    #      got: ["Captain Cook", "Captain Kidd", "William Kyd", "Arel English", "Henry Hudson", "Samuel Axe"]

    Captain.joins(boats: :classifications).where.not(classifications: { name: "Sailboat" }).distinct
  end

end


# rspec spec/models/captain_spec.rb
