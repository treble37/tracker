FactoryGirl.define do
  factory :task do
    name { generate(:name) }
    description { generate(:description) }
    state "in_progress"
  end
end
