FactoryGirl.define do
  sequence(:email) { |n| "email#{n}@example.com" }
  sequence(:name) { |n| "Name #{n}" }
  sequence(:description) { |n| "Description #{n}" }
end
