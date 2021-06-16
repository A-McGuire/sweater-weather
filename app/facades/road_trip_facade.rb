class RoadTripFacade
  class << self
    def get_trip_details(params)
      if directions(params)[:route][:routeError][:errorCode] == 2
        travel_time = 'Impossible route'
        weather_at_eta = {}
      else
        travel_time_nearest_hour = travel_time_to_nearest_hour(directions(params)[:route][:realTime])

        forcast = destination_forcast(params[:destination], travel_time_nearest_hour)
        travel_time = directions(params)[:route][:formattedTime]
        
        weather_at_eta = {
          temperature: forcast[:hourly_weather][travel_time_nearest_hour - 1][:temperature],
          conditions: forcast[:hourly_weather][travel_time_nearest_hour - 1][:conditions]
        }
      end

      start_city = params[:origin]
      end_city = params[:destination]

      OpenStruct.new(
        id: nil, start_city: start_city, end_city: end_city,
        travel_time: travel_time, weather_at_eta: weather_at_eta
      )
    end

    def directions(params)
      Rails.cache.fetch("Directions from #{params[:origin]} to #{params[:destination]}", expires_in: 1.hour) do
        MapQuestService.get_directions(params)
      end
    end

    def destination_forcast(destination, time)
      Rails.cache.fetch("Forcast for #{destination}, in #{time} hours", expires_in: 1.hour) do
        ForcastFacade.location_weather_data(destination, time)
      end
    end

    def travel_time_to_nearest_hour(seconds)
      (seconds / 3600.0).round
    end
  end
end
