RSpec.shared_examples 'api resource response' do
  it { expect(response.to_json).to include_json(serialized) }
end

RSpec.shared_examples 'correct status code' do |status_code|
  it { expect(last_response.status).to eq(status_code) }
end
