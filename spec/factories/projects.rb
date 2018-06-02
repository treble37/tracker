# == Schema Information
#
# Table name: projects
#
#  id          :uuid             not null, primary key
#  name        :string
#  description :text
#  state       :integer          default(10)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_projects_on_name  (name) UNIQUE
#

FactoryGirl.define do
  factory :project do
    id { SecureRandom.uuid }
    name { generate(:name) }
    description { generate(:description) }

    factory :project_with_tasks do
      after :create do |project|
        create_list :task, 2, project: project
      end
    end
  end
end
