class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    puts "catamaran_operators"
    Captain.all.each do |c|
      puts "Captain = name: #{c.name} || admiral?: #{c.admiral}"
    end
  end

  def self.sailors
    puts "sailors"
  end

  def self.talented_seafarers
    puts "talented_seafarers"
  end

  def self.non_sailors
    puts "non_sailors"
  end


end


# rspec spec/models/captain_spec.rb
