class RoadTripFacade
  class << self
    def travel_time_to_nearest_hour(seconds)
      minutes = seconds / 60.0
      (minutes / 60).round
    end

    def impossible_route(params)
      start_city = params[:origin]
      end_city = params[:destination]

      travel_time = 'Impossible route'
      weather_at_eta = {}

      OpenStruct.new(
        id: nil, start_city: start_city, end_city: end_city,
        travel_time: travel_time, weather_at_eta: weather_at_eta
      )
    end

    def get_trip_details(params)
      @directions = MapQuestService.get_directions(params)
      
      return impossible_route(params) if @directions[:route][:routeError][:errorCode] == 2

      travel_time_seconds = @directions[:route][:realTime]
      forcast = ForcastFacade.location_weather_data(params[:destination],
                                                    travel_time_to_nearest_hour(travel_time_seconds))

      start_city = params[:origin]
      end_city = params[:destination]

      travel_time = @directions[:route][:formattedTime]
      weather_at_eta = {
        temperature: forcast[:hourly_weather][travel_time_to_nearest_hour(travel_time_seconds) - 1][:temperature],
        conditions: forcast[:hourly_weather][travel_time_to_nearest_hour(travel_time_seconds) - 1][:conditions]
      }

      OpenStruct.new(
        id: nil, start_city: start_city, end_city: end_city,
        travel_time: travel_time, weather_at_eta: weather_at_eta
      )
    end
  end
end
