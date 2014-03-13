FactoryGirl.define do
  factory :h_28, class: Boat do
    name "H 28"
    length 27
    before :create do |boat|
      boat.captain = FactoryGirl.create(:captain_name_goes_here)
    end
    after :create do |boat|
      boat.classifications << [Factory(:ketch), Factory(:sailboat)]
    end
  end

  factory :nacra_17, class: Boat do
    name "Nacra 17"
    length 17
    before :create do |boat|
      boat.captain = FactoryGirl.create(:captain_name_goes_here)
    end
    after :create do |boat|
      boat.classifications << [Factory(:catamaran), Factory(:sloop), Factory(:sailboat)]
    end
  end

  factory :regulator, class: Boat do
    name "Regulator 34SS"
    length 34
    before :create do |boat|
      boat.captain = FactoryGirl.create(:captain_name_goes_here)
    end
    after :create do |boat|
      boat.classifications << [Factory(:motorboat), Factory(:center)]
    end
  end

  factory :zodiac, class: Boat do
    name "Zodiac C27"
    length 24
    before :create do |boat|
      boat.captain = FactoryGirl.create(:captain_name_goes_here)
    end
    after :create do |boat|
      boat.classifications << [Factory(:rib), Factory(:motorboat), Factory(:center)]
    end
  end

  factory :boston_whaler, class: Boat do
    name "Boston Whaler"
    length 13
    before :create do |boat|
      boat.captain = FactoryGirl.create(:captain_name_goes_here)
    end
    after :create do |boat|
      boat.classifications << [Factory(:motorboat)]
    end
  end

  factory :forty_niner, class: Boat do
    name "49er"
    length 16
    before :create do |boat|
      boat.captain = FactoryGirl.create(:captain_name_goes_here)
    end
    after :create do |boat|
      boat.classifications << [Factory(:sailboat), Factory(:sloop)]
    end
  end

  factory :cape_dory, class: Boat do
    name "Cape Dory"
    length 28
    before :create do |boat|
      boat.captain = FactoryGirl.create(:captain_name_goes_here)
    end
    after :create do |boat|
      boat.classifications << [Factory(:motorboat), Factory(:trawler)]
    end
  end

  factory :laser, class: Boat do
    name "Laser"
    length 14
    before :create do |boat|
      boat.captain = FactoryGirl.create(:captain_name_goes_here)
    end
    after :create do |boat|
      boat.classifications << [Factory(:sailboat), Factory(:cat_rig)]
    end
  end

  factory :triton, class: Boat do
    name "Triton 21 TRX"
    length 21
    before :create do |boat|
      boat.captain = FactoryGirl.create(:captain_name_goes_here)
    end
    after :create do |boat|
      boat.classifications << [Factory(:motorboat), Factory(:bass)]
    end
  end

  factory :sun_tracker, class: Boat do
    name "Sun Tracker Regency 254 XP3"
    length 27
    before :create do |boat|
      boat.captain = FactoryGirl.create(:captain_name_goes_here)
    end
    after :create do |boat|
      boat.classifications << [Factory(:motorboat), Factory(:pontoon)]
    end
  end

  factory :harpoon, class: Boat do
    name "Harpoon 4.7"
    length 16
    after :create do |boat|
      boat.classifications << [Factory(:sailboat), Factory(:sloop)]
    end
  end

  factory :sunfish, class: Boat do
    name "Sunfish"
    length 14
    after :create do |boat|
      boat.classifications << [Factory(:sailboat), Factory(:cat_rig)]
    end
  end
end