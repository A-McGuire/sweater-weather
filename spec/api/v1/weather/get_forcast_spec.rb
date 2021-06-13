require 'rails_helper'

RSpec.describe '/forcast', :vcr do
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
      :datetime, :sunrise, :sunset, :temperature, :feels_like, 
      :humidity, :uvi, :visibility, :conditions, :icon
      ])
      
    expect(forcast[:data][:attributes][:current_weather][:datetime]).to be_a String
    expect(forcast[:data][:attributes][:current_weather][:sunrise]).to be_a String
    expect(forcast[:data][:attributes][:current_weather][:sunset]).to be_a String
    expect(forcast[:data][:attributes][:current_weather][:temperature]).to be_a Float
    expect(forcast[:data][:attributes][:current_weather][:feels_like]).to be_a Float
    expect(forcast[:data][:attributes][:current_weather][:humidity]).to be_a Integer # or float
    expect(forcast[:data][:attributes][:current_weather][:uvi]).to be_a Float # or int
    expect(forcast[:data][:attributes][:current_weather][:visibility]).to be_a Integer # or float
    expect(forcast[:data][:attributes][:current_weather][:conditions]).to be_a String
    expect(forcast[:data][:attributes][:current_weather][:icon]).to be_a String
  end

  it 'has the correct keys and datatypes for daily_weather' do
    get '/api/v1/forcast'

    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    forcast = JSON.parse(response.body, symbolize_names: true)

    expect(forcast[:data][:attributes][:daily_weather]).to be_an Array
    expect(forcast[:data][:attributes][:daily_weather].first.keys.count).to eq(7)
    expect(forcast[:data][:attributes][:daily_weather].first.keys)
    .to eq([:date, :sunrise, :sunset, :max_temp, :min_temp, :conditions, :icon])

    expect(forcast[:data][:attributes][:daily_weather].first[:date]).to be_a String
    expect(forcast[:data][:attributes][:daily_weather].first[:sunrise]).to be_a String
    expect(forcast[:data][:attributes][:daily_weather].first[:sunset]).to be_a String
    expect(forcast[:data][:attributes][:daily_weather].first[:max_temp]).to be_a Float
    expect(forcast[:data][:attributes][:daily_weather].first[:min_temp]).to be_a Float
    expect(forcast[:data][:attributes][:daily_weather].first[:conditions]).to be_a String
    expect(forcast[:data][:attributes][:daily_weather].first[:icon]).to be_a String
  end

  it 'has the correct keys and datatypes for hourly_weather' do
    get '/api/v1/forcast'

    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    forcast = JSON.parse(response.body, symbolize_names: true)

    expect(forcast[:data][:attributes][:hourly_weather]).to be_an Array
    expect(forcast[:data][:attributes][:hourly_weather].first.keys.count).to eq(4)
    expect(forcast[:data][:attributes][:hourly_weather].first.keys)
    .to eq([:time, :temperature, :conditions, :icon])
    
    expect(forcast[:data][:attributes][:hourly_weather].first[:time]).to be_a String
    expect(forcast[:data][:attributes][:hourly_weather].first[:temperature]).to be_a Float
    expect(forcast[:data][:attributes][:hourly_weather].first[:conditions]).to be_a String
    expect(forcast[:data][:attributes][:hourly_weather].first[:icon]).to be_a String
  end

  it 'does not have any unnessesary data for current weather' do
    get '/api/v1/forcast'

    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    forcast = JSON.parse(response.body, symbolize_names: true)
    
    expect(forcast[:data].include?(:lat)).to eq(false)
    expect(forcast[:data].include?(:lon)).to eq(false)
    expect(forcast[:data].include?(:timezone)).to eq(false)
    expect(forcast[:data].include?(:timezone_offset)).to eq(false)
    expect(forcast[:data].include?(:minutely)).to eq(false)
    expect(forcast[:data].include?(:alerts)).to eq(false)
    expect(forcast[:data][:attributes][:current_weather].include?(:dt)).to eq(false)
    expect(forcast[:data][:attributes][:current_weather].include?(:pressure)).to eq(false)
    expect(forcast[:data][:attributes][:current_weather].include?(:dew_point)).to eq(false)
    expect(forcast[:data][:attributes][:current_weather].include?(:clouds)).to eq(false)
    expect(forcast[:data][:attributes][:current_weather].include?(:wind_speed)).to eq(false)
    expect(forcast[:data][:attributes][:current_weather].include?(:wind_deg)).to eq(false)
    expect(forcast[:data][:attributes][:current_weather].include?(:wind_gust)).to eq(false)
  end

  it 'does not have any unnessesary data for daily weather' do
    get '/api/v1/forcast'

    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    forcast = JSON.parse(response.body, symbolize_names: true)
    
    expect(forcast[:data][:attributes][:daily_weather].include?(:dt)).to eq(false)
    expect(forcast[:data][:attributes][:daily_weather].include?(:moonrise)).to eq(false)
    expect(forcast[:data][:attributes][:daily_weather].include?(:moonset)).to eq(false)
    expect(forcast[:data][:attributes][:daily_weather].include?(:moonphase)).to eq(false)
    expect(forcast[:data][:attributes][:daily_weather].include?(:pressure)).to eq(false)
    expect(forcast[:data][:attributes][:daily_weather].include?(:dew_point)).to eq(false)
    expect(forcast[:data][:attributes][:daily_weather].include?(:clouds)).to eq(false)
    expect(forcast[:data][:attributes][:daily_weather].include?(:wind_speed)).to eq(false)
    expect(forcast[:data][:attributes][:daily_weather].include?(:wind_deg)).to eq(false)
    expect(forcast[:data][:attributes][:daily_weather].include?(:wind_gust)).to eq(false)
  end

  it 'does not have any unnessesary data for hourly weather' do
    get '/api/v1/forcast'

    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    forcast = JSON.parse(response.body, symbolize_names: true)
    
    expect(forcast[:data][:attributes][:hourly_weather].include?(:dt)).to eq(false)
    expect(forcast[:data][:attributes][:hourly_weather].include?(:pressure)).to eq(false)
    expect(forcast[:data][:attributes][:hourly_weather].include?(:dew_point)).to eq(false)
    expect(forcast[:data][:attributes][:hourly_weather].include?(:clouds)).to eq(false)
    expect(forcast[:data][:attributes][:hourly_weather].include?(:wind_speed)).to eq(false)
    expect(forcast[:data][:attributes][:hourly_weather].include?(:wind_deg)).to eq(false)
    expect(forcast[:data][:attributes][:hourly_weather].include?(:wind_gust)).to eq(false)
    expect(forcast[:data][:attributes][:hourly_weather].include?(:pop)).to eq(false)
  end
end
