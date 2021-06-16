class UnsplashService 
  class << self
    def get_location_image(location)
      resp = conn.get('/search/photos') do |req|
        req.params['query'] = location
        req.headers['Authorization'] = "Client-ID #{ENV['unsplash_client_id']}"
      end
      GeneralService.parse_data(resp)
    end

    private

    def conn
      GeneralService.conn('https://api.unsplash.com')
    end
  end
end
