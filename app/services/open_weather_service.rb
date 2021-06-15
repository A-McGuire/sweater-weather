class OpenWeatherService
  class << self
    def get_location_weather(location)
      resp = conn.get('onecall') do |req|
        req.params['appid'] = ENV['open_weather_key']
        req.params['lat'] = location[:lat]
        req.params['lon'] = location[:lng]
        req.params['exclude'] = 'minutely,alerts'
        req.params['units'] = 'imperial'
      end
      GeneralService.parse_data(resp)
    end

    private

    def conn
      GeneralService.conn('https://api.openweathermap.org/data/2.5/')
    end
  end
end
