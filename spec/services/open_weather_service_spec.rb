require 'rails_helper'

RSpec.describe 'open weather service', :vcr do
  it 'returns data in the correct format' do
    location = {lat: 39.738453, lng: -104.984853}
    
    data = OpenWeatherService.get_location_weather(location)
    
    expect(data).to be_a Hash
    expect(data.keys.count).to eq(7)
    expect(data.keys).to eq([:lat, :lon, :timezone, :timezone_offset, :current, :hourly, :daily])
    expect(data[:lat]).to be_a Float
    expect(data[:lon]).to be_a Float
    expect(data[:timezone]).to be_a String
    expect(data[:timezone_offset]).to be_a Integer

    expect(data[:current]).to be_a Hash
    expect(data[:current].keys.count).to eq(15)
    expect(data[:current].keys).to eq([
      :dt, :sunrise, :sunset, :temp, :feels_like, :pressure, 
      :humidity, :dew_point, :uvi, :clouds, :visibility, 
      :wind_speed, :wind_deg, :wind_gust, :weather
      ])
      
    expect(data[:current][:dt]).to be_a Integer
    expect(data[:current][:sunrise]).to be_a Integer
    expect(data[:current][:sunset]).to be_a Integer
    expect(data[:current][:temp]).to be_a Float
    expect(data[:current][:feels_like]).to be_a Float
    expect(data[:current][:pressure]).to be_a Integer
    expect(data[:current][:humidity]).to be_a Integer
    expect(data[:current][:dew_point]).to be_a Float
    expect(data[:current][:uvi]).to be_a Float
    expect(data[:current][:clouds]).to be_a Integer
    expect(data[:current][:visibility]).to be_a Integer
    expect(data[:current][:wind_speed]).to be_a Float
    expect(data[:current][:wind_deg]).to be_a Integer
    expect(data[:current][:wind_gust]).to be_a Integer
    expect(data[:current][:weather]).to be_an Array
    expect(data[:current][:weather].first.keys).to eq([:id, :main, :description, :icon])
    expect(data[:current][:weather].first[:id]).to be_a Integer
    expect(data[:current][:weather].first[:main]).to be_a String
    expect(data[:current][:weather].first[:description]).to be_a String
    expect(data[:current][:weather].first[:icon]).to be_a String

    expect(data[:hourly]).to be_an Array
    expect(data[:hourly].first.keys.count).to eq(14)
    expect(data[:hourly].first.keys).to eq([
      :dt, :temp, :feels_like, :pressure, 
      :humidity, :dew_point, :uvi, :clouds, :visibility, 
      :wind_speed, :wind_deg, :wind_gust, :weather, :pop
      ])
      
    expect(data[:hourly].first[:dt]).to be_a Integer
    expect(data[:hourly].first[:temp]).to be_a Float
    expect(data[:hourly].first[:feels_like]).to be_a Float
    expect(data[:hourly].first[:pressure]).to be_a Integer
    expect(data[:hourly].first[:humidity]).to be_a Integer
    expect(data[:hourly].first[:dew_point]).to be_a Float
    expect(data[:hourly].first[:uvi]).to be_a Float
    expect(data[:hourly].first[:clouds]).to be_a Integer
    expect(data[:hourly].first[:visibility]).to be_a Integer
    expect(data[:hourly].first[:wind_speed]).to be_a Float
    expect(data[:hourly].first[:wind_deg]).to be_a Integer
    expect(data[:hourly].first[:wind_gust]).to be_a Float
    expect(data[:hourly].first[:pop]).to be_a Integer
    expect(data[:hourly].first[:weather]).to be_an Array
    expect(data[:hourly].first[:weather].first.keys).to eq([:id, :main, :description, :icon])
    expect(data[:hourly].first[:weather].first[:id]).to be_a Integer
    expect(data[:hourly].first[:weather].first[:main]).to be_a String
    expect(data[:hourly].first[:weather].first[:description]).to be_a String
    expect(data[:hourly].first[:weather].first[:icon]).to be_a String

    expect(data[:daily]).to be_an Array
    expect(data[:daily].first.keys.count).to eq(18)
    expect(data[:daily].first.keys).to eq([
      :dt, :sunrise, :sunset, :moonrise, :moonset, :moon_phase, :temp, :feels_like, :pressure, 
      :humidity, :dew_point, :wind_speed, :wind_deg, :wind_gust, :weather, :clouds, :pop, :uvi
      ])
      
    expect(data[:daily].first[:dt]).to be_a Integer
    expect(data[:daily].first[:sunrise]).to be_a Integer
    expect(data[:daily].first[:sunset]).to be_a Integer
    expect(data[:daily].first[:moonrise]).to be_a Integer
    expect(data[:daily].first[:moonset]).to be_a Integer
    expect(data[:daily].first[:moon_phase]).to be_a Float
    expect(data[:daily].first[:temp]).to be_a Hash

    expect(data[:daily].first[:temp].keys).to eq([:day, :min, :max, :night, :eve, :morn])
    expect(data[:daily].first[:temp][:day]).to be_a Float
    expect(data[:daily].first[:temp][:min]).to be_a Float
    expect(data[:daily].first[:temp][:max]).to be_a Float
    expect(data[:daily].first[:temp][:night]).to be_a Float
    expect(data[:daily].first[:temp][:eve]).to be_a Float
    expect(data[:daily].first[:temp][:morn]).to be_a Float

    expect(data[:daily].first[:feels_like]).to be_a Hash
    expect(data[:daily].first[:feels_like].keys).to eq([:day, :night, :eve, :morn])
    expect(data[:daily].first[:feels_like][:day]).to be_a Float
    expect(data[:daily].first[:feels_like][:night]).to be_a Float
    expect(data[:daily].first[:feels_like][:eve]).to be_a Float
    expect(data[:daily].first[:feels_like][:morn]).to be_a Float

    expect(data[:daily].first[:pressure]).to be_a Integer
    expect(data[:daily].first[:humidity]).to be_a Integer
    expect(data[:daily].first[:dew_point]).to be_a Float
    expect(data[:daily].first[:wind_speed]).to be_a Float
    expect(data[:daily].first[:wind_deg]).to be_a Integer
    expect(data[:daily].first[:wind_gust]).to be_a Float

    expect(data[:daily].first[:weather]).to be_an Array
    expect(data[:daily].first[:weather].first.keys).to eq([:id, :main, :description, :icon])
    expect(data[:daily].first[:weather].first[:id]).to be_a Integer
    expect(data[:daily].first[:weather].first[:main]).to be_a String
    expect(data[:daily].first[:weather].first[:description]).to be_a String
    expect(data[:daily].first[:weather].first[:icon]).to be_a String
    
    expect(data[:daily].first[:clouds]).to be_a Integer
    expect(data[:daily].first[:pop]).to be_a Float
    expect(data[:daily].first[:uvi]).to be_a Float
  end
end