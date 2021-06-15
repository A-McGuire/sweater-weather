class ForcastFacade
  class << self
    def location_weather_data(address, hours = 8)
      location = MapQuestService.get_location_details(address)
      data = OpenWeatherService.get_location_weather(location[:results].first[:locations].first[:latLng])
      
      current = {
        datetime: Time.zone.at(data[:current][:dt]).to_s,
        sunrise: Time.zone.at(data[:current][:sunrise]).to_s,
        sunset: Time.zone.at(data[:current][:sunset]).to_s,
        temperature: data[:current][:temp],
        feels_like: data[:current][:feels_like],
        humidity: data[:current][:humidity],
        uvi: data[:current][:uvi],
        visibility: data[:current][:visibility],
        conditions: data[:current][:weather].first[:description],
        icon: data[:current][:weather].first[:icon]
      }

      by_day = data[:daily].first(5).map do |day|
        {
          date: Time.zone.at(day[:dt]).strftime('%Y-%m-%d'),
          sunrise: Time.zone.at(day[:sunrise]).to_s,
          sunset: Time.zone.at(day[:sunset]).to_s,
          max_temp: day[:temp][:max],
          min_temp: day[:temp][:min],
          conditions: day[:weather].first[:description],
          icon: day[:weather].first[:icon]
        }
      end

      by_hour = data[:hourly].first(hours).map do |hour|
        {
          time: Time.zone.at(hour[:dt]).strftime('%H:%M:%S'),
          temperature: hour[:temp],
          conditions: hour[:weather].first[:description],
          icon: hour[:weather].first[:icon]
        }
      end

      OpenStruct.new(id: nil, current_weather: current, daily_weather: by_day, hourly_weather: by_hour)
    end
  end
end
