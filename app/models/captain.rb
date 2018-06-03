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

    # NOTE : "Hacked" solution to identify the logic at least
    seafarers = {}
    Captain.all.each do |c|
      c.boats.each do |b|
        b.classifications.each do |cl|
          if cl.name == "Sailboat" || cl.name == "Motorboat"
            # puts "    Classification = #{cl.name}"
            if !seafarers.has_key?(c.name)
              # puts "Add seafarer : #{c.name}"
              seafarers[c.name] = []
            end
            if !seafarers[c.name].include?(cl.name)
              seafarers[c.name] << cl.name
            end
          end
        end
      end
    end
    # puts "Seafarers = #{seafarers}"
    talented = []
    seafarers.each do |capt, cl_array|
      if cl_array.size > 1
        talented << capt
      end
    end
    # puts "talented = #{talented}"
    Captain.where(name: talented)



    # NOTE : Couldn't get this to work... -- ask a question for refactoring/query help
    # expected: ["Captain Cook", "Samuel Axe"]
    #      got: ["Captain Cook", "Captain Kidd", "William Kyd", "Arel English", "Henry Hudson", "Samuel Axe"]
    # Captain.joins(boats: :classifications).where(classifications: { name: ["Sailboat", "Motorboat"] }).distinct

    # Captain.joins(boats: :classifications).where('classifications.name = ? AND classifications.name = ?', "Sailboat", "Motorboat")
    # Captain.joins(boats: :classifications).select("*").group("captains.name, boats.id").having("classifications.name = ? AND classifications.name = ?", "Sailboat", "Motorboat")

  end

  def self.non_sailors
    puts "non_sailors"

    # NOTE : "Hacked" solution to identify the logic at least
    sailors = Captain.sailors.pluck(:name)
    puts "Sailors = #{sailors}"
    Captain.where.not(name: sailors)

    # expected: ["William Kyd", "Arel English", "Henry Hudson"]

    # Captain.all.each do |c|
    #   puts "Captain = name: #{c.name} || admiral?: #{c.admiral}"
    #   c.boats.each do |b|
    #     puts "  Boat = #{b.name}"
    #     b.classifications.each do |cl|
    #       if cl.name == "Sailboat" || cl.name == "Motorboat"
    #         puts "    Classification = #{cl.name}"
    #       end
    #     end
    #   end
    # end

    # NOTE : Couldn't get this to work... -- ask a question for refactoring/query help
    # expected: ["William Kyd", "Arel English", "Henry Hudson"]
    #      got: ["Captain Cook", "Captain Kidd", "William Kyd", "Arel English", "Henry Hudson", "Samuel Axe"]
    # Captain.joins(boats: :classifications).select("*").group("captains.id").where.not(classifications: { name: "Sailboat" }).distinct
    # Captain.joins(boats: :classifications).where.not(classifications: { name: "Sailboat" }).distinct
    # Captain.joins(boats: :classifications).select("captains.name as name, boats.name as boat_name, classifications.name as classification").group("captains.id")
  end

end


# rspec spec/models/captain_spec.rb
