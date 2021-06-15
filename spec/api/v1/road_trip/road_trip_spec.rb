require 'rails_helper'

RSpec.describe 'POST /users', :vcr do
  it 'returns the correct json structure' do
    user = User.create!(email: 'whatever@example.com', password: 'password')

    body = {
        "origin": "Denver,CO",
        "destination": "Estes Park, CO",
        "auth_token": "#{user.auth_token}"
    }

    post '/api/v1/road_trip', params: body.to_json, headers: { "Content-Type": "application/json", "Accept": "application/json" }

    user = User.find_by(email: 'whatever@example.com')
    
    expect(response).to be_successful
    expect(response.status).to eq(200)

    resp = JSON.parse(response.body, symbolize_names: true)
    
    expect(resp.keys).to eq([:data])
    expect(resp[:data]).to be_a Hash
    expect(resp[:data].keys).to eq([:id, :type, :attributes])
    expect(resp[:data][:type]).to eq('roadtrip')
    expect(resp[:data][:id]).to eq(nil)
    expect(resp[:data][:attributes]).to be_a Hash
    expect(resp[:data][:attributes].keys).to eq([:start_city, :end_city, :travel_time, :weather_at_eta])
    expect(resp[:data][:attributes][:start_city]).to be_a String
    expect(resp[:data][:attributes][:end_city]).to be_a String
    expect(resp[:data][:attributes][:travel_time]).to be_a String
    expect(resp[:data][:attributes][:weather_at_eta]).to be_a Hash
    expect(resp[:data][:attributes][:weather_at_eta].keys).to eq([:temperature, :conditions])
    expect(resp[:data][:attributes][:weather_at_eta][:temperature]).to be_a Float
    expect(resp[:data][:attributes][:weather_at_eta][:conditions]).to be_a String
  end
end