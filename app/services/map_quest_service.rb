class MapQuestService < GeneralService
  class << self
    def get_location_details(location)
      resp = conn.get('address') do |req|
        req.params['key'] = ENV['mapquest_key']
        req.params['location'] = location
      end
      GeneralService.parse_data(resp)
    end

    def get_directions(params)
      resp = conn_v2.get('route') do |req|
        req.params['key'] = ENV['mapquest_key']
        req.params['from'] = params[:origin]
        req.params['to'] = params[:destination]
      end
      GeneralService.parse_data(resp)
    end

    private

    def conn
      Faraday.new(url: 'http://www.mapquestapi.com/geocoding/v1/') do |faraday|
        faraday.headers['Accept'] = '*/*'
      end
    end

    def conn_v2
      Faraday.new(url: 'http://www.mapquestapi.com/directions/v2/') do |faraday|
        faraday.headers['Accept'] = '*/*'
      end
    end

    # def parse_data(resp)
    #   JSON.parse(resp.body, symbolize_names: true)
    # end
  end
end
