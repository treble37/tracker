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

class Task < ActiveRecord::Base
  include Twil

  validates :name, presence: true

  enum state: {
    todo: -1,
    in_progress: 0,
    done: 1
  }

  validates :state, presence: true, inclusion: { in: states.keys }

  belongs_to :project

  after_initialize :set_default_state

  private

  def set_default_state
    self.state ||= :todo
  end
end
