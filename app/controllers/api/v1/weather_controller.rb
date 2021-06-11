class Api::V1::WeatherController < ApplicationController
  def forcast
    # location = MapQuestService.get_location_details(location)
    location = MapQuestService.get_location_details('denver, co')
    forcast = OpenWeatherService.get_location_weather(location[:results].first[:locations].first[:latLng])
  end
end