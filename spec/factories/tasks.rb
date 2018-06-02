# == Schema Information
#
# Table name: tasks
#
#  id          :uuid             not null, primary key
#  state       :integer
#  name        :string
#  description :text
#  project_id  :uuid
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_tasks_on_project_id  (project_id)
#

FactoryGirl.define do
  factory :task do
    id { SecureRandom.uuid }
    name { generate(:name) }
    description { generate(:description) }
    state 'in_progress'
    project
  end
end
