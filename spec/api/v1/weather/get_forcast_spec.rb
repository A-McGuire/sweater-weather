require 'rails_helper'

RSpec.describe '/forcast' do
  it 'can get a locations weather forcast' do

    get '/api/v1/forcast'

    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    forcast = JSON.parse(response.body, symbolize_names: true)

    expect(forcast).to be_a Hash
    expect(forcast).to have_key(:data)
    expect(forcast[:data]).to be_a Hash
    expect(forcast[:data].keys).to eq([:id, :type, :attributes])
    expect(forcast[:data][:id]).to eq(nil)
    expect(forcast[:data][:type]).to eq('forcast')
    expect(forcast[:data][:attributes].keys).to eq([:current_weather, :daily_weather, :hourly_weather])
    
    # expect(forcast[:data][:attributes][:daily_weather]).to be_a Hash
    # expect(forcast[:data][:attributes][:daily_weather].keys.count).to eq(7)
    # expect(forcast[:data][:attributes][:daily_weather].keys).to eq([:date, :sunrise, :sunset, :max_temp, :min_temp, :conditions, :icon])
    
  end

  it 'has the correct keys and datatypes for current_weather' do
    get '/api/v1/forcast'

    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    forcast = JSON.parse(response.body, symbolize_names: true)

    expect(forcast[:data][:attributes][:current_weather]).to be_a Hash
    expect(forcast[:data][:attributes][:current_weather].keys.count).to eq(10)
    expect(forcast[:data][:attributes][:current_weather].keys)
    .to eq([
      :datatime, :sunrise, :sunset, :temperature, :feels_like, 
      :humidity, :uvi, :visibility, :conditons, :icon
      ])
      
    expect(forcast[:data][:attributes][:current_weather][:datatime]).to be_a String
    expect(forcast[:data][:attributes][:current_weather][:sunrise]).to be_a String
    expect(forcast[:data][:attributes][:current_weather][:sunset]).to be_a String
    expect(forcast[:data][:attributes][:current_weather][:temperature]).to be_a Float
    expect(forcast[:data][:attributes][:current_weather][:feels_like]).to be_a Float
    expect(forcast[:data][:attributes][:current_weather][:humidity]).to be_a Float # or int
    expect(forcast[:data][:attributes][:current_weather][:uvi]).to be_a Float # or int
    expect(forcast[:data][:attributes][:current_weather][:visibility]).to be_a Float # or int
    expect(forcast[:data][:attributes][:current_weather][:conditions]).to be_a String
    expect(forcast[:data][:attributes][:current_weather][:icon]).to be_a String
  end

  it 'has the correct keys and datatypes for daily_weather' do
    get '/api/v1/forcast'

    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    forcast = JSON.parse(response.body, symbolize_names: true)

    expect(forcast[:data][:attributes][:daily_weather]).to be_a Hash
    expect(forcast[:data][:attributes][:daily_weather].keys.count).to eq(7)
    expect(forcast[:data][:attributes][:daily_weather].keys)
    .to eq([:date, :sunrise, :sunset, :max_temp, :min_temp, :conditions, :icon])

    expect(forcast[:data][:attributes][:daily_weather][:date]).to be_a String
    expect(forcast[:data][:attributes][:daily_weather][:sunrise]).to be_a String
    expect(forcast[:data][:attributes][:daily_weather][:sunset]).to be_a String
    expect(forcast[:data][:attributes][:daily_weather][:max_temp]).to be_a Float
    expect(forcast[:data][:attributes][:daily_weather][:min_temp]).to be_a Float
    expect(forcast[:data][:attributes][:daily_weather][:conditions]).to be_a String
    expect(forcast[:data][:attributes][:daily_weather][:icon]).to be_a String
  end

  it 'has the correct keys and datatypes for hourly_weather' do
    get '/api/v1/forcast'

    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    forcast = JSON.parse(response.body, symbolize_names: true)

    expect(forcast[:data][:attributes][:hourly_weather]).to be_a Hash
    expect(forcast[:data][:attributes][:hourly_weather].keys.count).to eq(4)
    expect(forcast[:data][:attributes][:hourly_weather].keys)
    .to eq([:time, :temperature, :conditons, :icon])

    expect(forcast[:data][:attributes][:daily_weather][:time]).to be_a String
    expect(forcast[:data][:attributes][:daily_weather][:temperature]).to be_a Float
    expect(forcast[:data][:attributes][:daily_weather][:conditions]).to be_a String
    expect(forcast[:data][:attributes][:daily_weather][:icon]).to be_a String
  end
end
