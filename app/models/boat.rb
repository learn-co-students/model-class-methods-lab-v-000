class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    select(:name).limit(5)#Model.select(:field)# => [#<Model field:value>]https://apidock.com/rails/v4.0.2/ActiveRecord/QueryMethods/select
  end

  def self.dinghy
    where("length <= ?", 20)#Now what if that number could vary, say as an argument from somewhere,http://guides.rubyonrails.org/active_record_querying.html#conditions
  end

  def self.ship
    where("lenght >= ?", 20)#Now what if that number could vary, say as an argument from somewhere,http://guides.rubyonrails.org/active_record_querying.html#conditions
  end

  def self.last_three_alphabetically
    select(:name).order(name: :desc).limit(3) #https://apidock.com/rails/ActiveRecord/QueryMethods/order
    #binding.pry
  end

  def self.without_a_captain
    where("captain_id = ?",nil)
  end
end
