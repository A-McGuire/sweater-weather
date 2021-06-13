require 'rails_helper'

RSpec.describe 'forcast facade', :vcr do
  it 'creates an object with the correct attributes' do
    data = ForcastFacade.location_weather_data('denver, co')

    expect(data.id).to eq(nil)
    
    expect(data.current_weather).to be_a Hash
    expect(data[:current_weather].keys.count).to eq(10)
    expect(data[:current_weather].keys)
    .to eq([
      :datetime, :sunrise, :sunset, :temperature, :feels_like, 
      :humidity, :uvi, :visibility, :conditions, :icon
      ])
    
    expect(data.daily_weather).to be_an Array
    expect(data[:daily_weather]).to be_an Array
    expect(data[:daily_weather].first.keys.count).to eq(7)
    expect(data[:daily_weather].first.keys)
    .to eq([:date, :sunrise, :sunset, :max_temp, :min_temp, :conditions, :icon])

    expect(data.hourly_weather).to be_an Array
    expect(data[:hourly_weather]).to be_an Array
    expect(data[:hourly_weather].first.keys.count).to eq(4)
    expect(data[:hourly_weather].first.keys)
    .to eq([:time, :temperature, :conditions, :icon])
  end
end