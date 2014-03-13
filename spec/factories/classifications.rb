FactoryGirl.define do
  factory :ketch, class: Classification do
    name "Ketch"
  end

  factory :sailboat, class: Classification do
    name "Sailboat"
  end

  factory :catamaran, class: Classification do
    name "Catamaran"
  end

  factory :sloop, class: Classification do
    name "Sloop"
  end

  factory :motorboat, class: Classification do
    name "Motorboat"
  end

  factory :center, class: Classification do
    name "Center Console"
  end

  factory :rib, class: Classification do
    name "RIB"
  end

  factory :trawler, class: Classification do
    name "Trawler"
  end

  factory :cat_rig, class: Classification do
    name "Cat Rig Boat"
  end

  factory :bass, class: Classification do
    name "Bass Boat"
  end

  factory :pontoon, class: Classification do
    name "Pontoon Boat"
  end
end