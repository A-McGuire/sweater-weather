require 'rails_helper'

RSpec.describe 'unsplash service', :vcr do
  it 'returns data in the correct format' do
    location = 'denver, co'
    data = UnsplashService.get_location_image(location)
    
    expect(data).to be_a Hash
    expect(data.keys).to eq([:total, :total_pages, :results])
    expect(data[:results]).to be_an Array
    expect(data[:results].first).to be_a Hash
    expect(data[:results].first.keys.include?(:urls)).to eq(true)
    expect(data[:results].first[:urls]).to be_a Hash
    expect(data[:results].first[:urls].keys).to eq([:raw, :full, :regular, :small, :thumb])

    expect(data[:results].first.keys.include?(:user)).to eq(true)
    expect(data[:results].first[:user].keys.include?(:username)).to eq(true)
    expect(data[:results].first[:user].keys.include?(:links)).to eq(true)
    expect(data[:results].first[:user][:username]).to be_a String
    expect(data[:results].first[:user][:links]).to be_a Hash
    expect(data[:results].first[:user][:links].keys.include?(:self)).to eq(true)
    expect(data[:results].first[:user][:links][:self]).to be_a String
  end
end