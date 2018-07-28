class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

  def self.longest
    Boat.order(length: :desc).first.classifications
  end
end


#describe Classification do
#  describe "::my_all" do
#    it "returns all classifications" do
#      classifications = ["Ketch", "Sailboat", "Catamaran", "Sloop", "Motorboat", "Center Console", "RIB", "Trawler", "Cat Rig Boat", "Bass Boat", "Pontoon Boat"]
#      expect(Classification.my_all.pluck(:name).uniq).to eq(classifications)
#    end
#  end

#  describe "#longest" do
#    it "returns the classifications for the longest boat" do
#      classifications = ["Motorboat", "Center Console"]
#      expect(Classification.longest.pluck(:name)).to eq(classifications)
#    end
#  end
#end
