# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  state       :integer
#  name        :string
#  description :text
#  project_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_tasks_on_project_id  (project_id)
#

class Task < ActiveRecord::Base
  validates :name, presence: true

  validates :state, presence: true

  belongs_to :project

  after_initialize :set_default_state

  enum state: {
    in_progress: 0,
    todo: 1,
    done: 2
  }

  private

  def set_default_state
    self.state ||= :in_progress
  end
end
