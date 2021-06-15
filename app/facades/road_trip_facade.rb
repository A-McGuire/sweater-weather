class RoadTripFacade
  class << self
    def get_trip_details(params)
      @directions = MapQuestService.get_directions(params)
      
      travel_time_seconds = @directions[:route][:realTime]
      start_city = params[:origin]
      end_city = params[:destination]
      
      if @directions[:route][:routeError][:errorCode] == 2
        travel_time = 'Impossible route'
        weather_at_eta = {}
      else
        forcast = ForcastFacade.location_weather_data(params[:destination],
          travel_time_to_nearest_hour(travel_time_seconds))

        travel_time = @directions[:route][:formattedTime]
        weather_at_eta = {
          temperature: forcast[:hourly_weather][travel_time_to_nearest_hour(travel_time_seconds) - 1][:temperature],
          conditions: forcast[:hourly_weather][travel_time_to_nearest_hour(travel_time_seconds) - 1][:conditions]
        }
      end
        
      OpenStruct.new(
        id: nil, start_city: start_city, end_city: end_city,
        travel_time: travel_time, weather_at_eta: weather_at_eta
      )
    end

    def travel_time_to_nearest_hour(seconds)
      minutes = seconds / 60.0
      (minutes / 60).round
    end
  end
end