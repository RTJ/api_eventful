module ApiEventful
  class Client
    attr_accessor :app_key

    def initialize(app_key: nil)
      @app_key = app_key || ApiEventful.app_key
    end

    def connection
      @connection ||= begin
        Faraday.new(:url => "http://api.eventful.com/") do |faraday|
          faraday.response :json, :content_type => /\bjson$/
          faraday.adapter  Faraday.default_adapter
        end
      end
    end

    def post(url, data = {})
      connection.post do |req|
        req.url "#{url}?app_key=#{@app_key}"
        req.headers['Content-Type'] = 'application/json'
        req.body = data.to_json
      end
    end

    def get(url, data = {})
      data = data.merge({app_key: @app_key})
      connection.get do |req|
        req.url url
        req.headers['Content-Type'] = 'application/json'
        req.params = data
      end
    end
  end
end
