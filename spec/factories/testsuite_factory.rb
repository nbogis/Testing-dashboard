FactoryGirl.define do
  factory :testsuite do
    product
    protocol
    sequence(:name) { |n| "testsuite_#{n}" }
  end

end
