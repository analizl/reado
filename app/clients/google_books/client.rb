module GoogleBooks
  class Client
    def send_request(method:, url:, event:, data: nil)
      request = GoogleBooks::Request.new(
        method: method,
        url: url,
        data: data
      )

      GoogleBooks.log(event: "[#{event}] [REQUEST]", details: request.inspect)

      request.call.tap do |response|
        GoogleBooks.log(event: "[#{event}] [RESPONSE]", details: response.status)
      end
    end
  end
end
