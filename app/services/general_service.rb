class GeneralService
  class << self
    def conn(url)
      Faraday.new(url: url) do |faraday|
        faraday.headers['Accept'] = '*/*'
      end
    end

    def parse_data(resp)
      JSON.parse(resp.body, symbolize_names: true)
    end
  end
end