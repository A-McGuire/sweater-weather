class RoadTripFacade
  class << self
    def travel_time_to_nearest_hour(seconds)
      minutes = seconds / 60.0
      hour = (minutes / 60).round
    end

    def get_trip_details(params)
      destination_forcast = ForcastFacade.location_weather_data(params[:destination])
      @directions = MapQuestService.get_directions(params)
      
      
      forcast = ForcastFacade.location_weather_data(params[:destination], self.travel_time_to_nearest_hour(@directions[:route][:realTime]))
      
      start_city = params[:origin]  
      end_city = params[:destination]
      travel_time = @directions[:route][:formattedTime]
      weather_at_eta = {
          temperature: forcast[:hourly_weather][self.travel_time_to_nearest_hour(@directions[:route][:realTime]) - 1][:temperature],
          conditions: forcast[:hourly_weather][self.travel_time_to_nearest_hour(@directions[:route][:realTime]) - 1][:conditions]
        }

      OpenStruct.new(
        id: nil, start_city: start_city, end_city: end_city, 
        travel_time: travel_time, weather_at_eta: weather_at_eta
      )
    end
  end
end