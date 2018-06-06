require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :state }
  it { should validate_presence_of :project }
  it { should belong_to(:project) }
  it { should define_enum_for(:state).with(todo: -1, in_progress: 0, done: 1) }
  it { should callback(:text_update).after(:update) }
end
