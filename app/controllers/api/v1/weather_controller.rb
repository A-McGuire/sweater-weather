class Api::V1::WeatherController < ApplicationController
  def forcast
    # location = MapQuestService.get_location_details(location)
    # location = MapQuestService.get_location_details('denver, co')
    # forcast = OpenWeatherService.get_location_weather(location[:results].first[:locations].first[:latLng])
    forcast = ForcastFacade.location_weather_data('denver, co')
    render json: ForcastSerializer.new(forcast).serializable_hash
  end
end
