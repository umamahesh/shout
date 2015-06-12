FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "test_user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
    
    # User CanCan roles
    trait(:admin) { role :admin }
    trait(:staff) { role :staff }
    trait(:client) { role :client }
  end

end
