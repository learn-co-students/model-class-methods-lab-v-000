FactoryGirl.define do
  factory :cook, class: Captain do
    name "Captain Cook"
    admiral true
  end
end

FactoryGirl.define do
  factory :kidd, class: Captain do
    name "Captain Kidd"
    admiral true
  end
end

can you do

FactoryGirl.define do
  factory :william, class: Captain do
    name "William Kyd"
    admiral false
  end
end

FactoryGirl.define do
  factory :arel, class: Captain do
    name "Arel English"
    admiral true
  end
end

FactoryGirl.define do
  factory :henry, class: Captain do
    name "Henry Hudson"
    admiral false
  end
end

FactoryGirl.define do
  factory :samuel, class: Captain do
    name "Samuel Axe"
    admiral false
  end
end