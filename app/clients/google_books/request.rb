module GoogleBooks
  class Request
    attr_accessor :method, :url, :data

    #AXP_OPEN_API_SECRET = ENV.fetch "AXP_OPEN_API_SECRET"

    def initialize(method:, url:, data: nil)
      @method = method
      @url = url
      @data = JSON.dump(data)
    end

    def call
      Rails.logger.info("[GOOGLE BOOKS][REQUEST] #{@method.upcase} - headers: #{headers.inspect} body: #{@data.inspect}")

      response = HTTP
        #.headers(headers)
        .send(@method.to_s.downcase, @url)

      Response.new(response)
    end
    
    private

    def headers
      {
        #"Authorization" => "Bearer #{AXP_OPEN_API_SECRET}",
        "Content-Type" => "application/json"
      }
    end
  end
end
