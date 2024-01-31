module GoogleBooks
  class Response
    attr_reader :status, :headers, :body

    def initialize(response)
      @status = response.code
      @headers = response.headers
      @body = JSON.parse(response.body)
    end
  end
end
