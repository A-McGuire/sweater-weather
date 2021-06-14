class OpenLibraryService
  class << self
    def get_location_books(location, quantity)
      resp = conn.get('search.json') do |req|
        req.params['q'] = location
        req.params['limit'] = quantity
      end
      parse_data(resp)
    end

    private

    def conn
      Faraday.new(url: 'http://openlibrary.org/') do |faraday|
        faraday.headers['Accept'] = '*/*'
      end
    end

    def parse_data(resp)
      JSON.parse(resp.body, symbolize_names: true)
    end
  end
end
