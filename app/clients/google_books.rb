require_relative "google_books/request"
require_relative "google_books/client"

module GoogleBooks
  def self.base_url
    ENV.fetch "GOOGLE_BOOKS_URL"
  end

  def self.log(level = :info, event:, details: nil)
    Rails.logger.send(level, "[GOOGLE BOOKS] #{event} #{details}")
  end
end
