FactoryGirl.define do
  factory :product do
    sequence(:name) { |n| "Product_#{n}" }
    dhf_num "V1"
  end
end
