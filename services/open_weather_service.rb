class OpenWeatherService
    class << self
    def get_location_weather(lat, lon)
      resp = conn.get('onecall') do |req|
        req.params['appid'] = ENV['open_weather_key']
        req.params['lat'] = lat
        req.params['lon'] = lon
      end
      parse_data(resp)
    end

    private

    def conn
      Faraday.new(url: 'https://api.openweathermap.org/data/2.5/') do |faraday|
        faraday.headers['Accept'] = '*/*'
      end
    end

    def parse_data(resp)
      JSON.parse(resp.body, symbolize_names: true)
    end
  end
end