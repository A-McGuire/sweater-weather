require 'rails_helper'

RSpec.describe 'mapquest service', :vcr do
  it 'returns data in the corrent format' do
    location = 'denver, co'
    data = MapQuestService.get_location_details(location)
    
    expect(data).to be_a Hash
    expect(data.keys).to eq([:info, :options, :results])
    expect(data[:results]).to be_an Array
    expect(data[:results].first).to be_a Hash
    expect(data[:results].first.keys).to eq([:providedLocation, :locations])
    expect(data[:results].first[:providedLocation].keys).to eq([:location])
    expect(data[:results].first[:providedLocation][:location]).to eq('denver, co')
    expect(data[:results].first[:locations].first.keys.count).to eq(22)
    expect(data[:results].first[:locations].first.keys.include?(:latLng)).to eq(true)
    expect(data[:results].first[:locations].first[:latLng]).to be_a Hash
    expect(data[:results].first[:locations].first[:latLng].keys).to eq([:lat, :lng])
    expect(data[:results].first[:locations].first[:latLng][:lat]).to be_a Float
    expect(data[:results].first[:locations].first[:latLng][:lng]).to be_a Float
  end
end