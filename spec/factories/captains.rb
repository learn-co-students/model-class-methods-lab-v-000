# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :captain do
    name: "Captain Cook"
    admiral: true
  end
end

FactoryGirl.define do
  factory :"Captain Kidd", class: Captain do
    name: "Captain Kidd"
    admiral: true
  end
end

can you do

FactoryGirl.define do
  factory :"William Kyd", class: Captain do
    name: "William Kyd"
    admiral: false
  end
end

FactoryGirl.define do
  factory :"Arel English", class: Captain do
    name: "Arel English"
    admiral: true
  end
end

FactoryGirl.define do
  factory :"Henry Hudson", class: Captain do
    name: "Henry Hudson"
    admiral: false
  end
end

FactoryGirl.define do
  factory :"Samuel Axe", class: Captain do
    name: "Samuel Axe"
    admiral: false
  end
end
