class RoadTripFacade
  class << self
    def get_trip_details(params)
      if map_quest_directions(params)[:route][:routeError][:errorCode] == 2
        travel_time = 'Impossible route'
        weather_at_eta = {}
      else
        travel_time_nearest_hour = travel_time_to_nearest_hour(map_quest_directions(params)[:route][:realTime])
        forcast = ForcastFacade.location_weather_data(params[:destination], travel_time_nearest_hour)
        travel_time = map_quest_directions(params)[:route][:formattedTime]
        weather_at_eta = set_weather(forcast, travel_time_nearest_hour)
      end

      start_city = params[:origin]
      end_city = params[:destination]

      OpenStruct.new(
        id: nil, start_city: start_city, end_city: end_city,
        travel_time: travel_time, weather_at_eta: weather_at_eta
      )
    end

    def map_quest_directions(params)
      Rails.cache.fetch("Directions from #{params[:origin]} to #{params[:destination]}", expires_in: 1.hours) do
        MapQuestService.get_directions(params)
      end
    end

    def set_weather(forcast, time)
      {
        temperature: forcast[:hourly_weather][time - 1][:temperature],
        conditions: forcast[:hourly_weather][time - 1][:conditions]
      }
    end

    def travel_time_to_nearest_hour(seconds)
      (seconds / 3600.0).round
    end
  end
end
