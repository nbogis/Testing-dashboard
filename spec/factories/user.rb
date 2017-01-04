FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |n| "Chuck#{n}" }
    last_name "Norris"
    email { "#{first_name}@exaxmple.com" }
    password "password"
    password_confirmation "password"
    auth_token SecureRandom.urlsafe_base64

  end
end
