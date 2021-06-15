class RoadTripFacade
  class << self
    def get_trip_details(params)
      destination_forcast = ForcastFacade.location_weather_data(params[:destination])
      @directions = MapQuestService.get_directions(params)
      forcast = ForcastFacade.location_weather_data(params[:destination])

      def realtime_to_nearest_hour
        minutes = @directions[:route][:realTime] / 60
        hour = minutes / 60
      end
      
      start_city = params[:origin]
      end_city = params[:destination]
      travel_time = @directions[:route][:formattedTime]
      weather_at_eta = {
          temperature: forcast[:hourly_weather][realtime_to_nearest_hour][:temperature],
          conditions: forcast[:hourly_weather][realtime_to_nearest_hour][:conditions]
        }

      OpenStruct.new(
        id: nil, start_city: start_city, end_city: end_city, 
        travel_time: travel_time, weather_at_eta: weather_at_eta
      )
    end
  end
end