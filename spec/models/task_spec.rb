require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :state }
  it { is_expected.to belong_to(:project) }
end
