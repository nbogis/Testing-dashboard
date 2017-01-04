FactoryGirl.define do
  factory :protocol do
    product

    sequence(:name) { |n| "Protocol_#{n}" }
    revision "B"
  end

end
