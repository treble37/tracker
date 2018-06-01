require 'rails_helper'

RSpec.describe Project, type: :model do
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should validate_presence_of :state }
  it { is_expected.to have_many(:tasks).dependent(:destroy) }
end
