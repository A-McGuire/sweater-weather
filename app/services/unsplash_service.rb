class UnsplashService
  class << self
    def get_location_image(location)
      resp = conn.get('/search/photos') do |req|
        req.params['query'] = location
        req.headers['Authorization'] = "Client-ID #{ENV['unsplash_client_id']}"
      end
      parse_data(resp)
    end

    private

    def conn
      Faraday.new(url: 'https://api.unsplash.com') do |faraday|
        faraday.headers['Accept'] = '*/*'
      end
    end

    def parse_data(resp)
      JSON.parse(resp.body, symbolize_names: true)
    end
  end
end
