class BooksController < ApplicationController
  BASE_URL = ENV.fetch "GOOGLE_BOOKS_URL"

  # TODO: what parts of the page are going to be for authenticated users
  # before_action :authenticate_user!

  def index
    @books = []

    if params["author"] || params["title"]
      @author_form = params["author"]
      @title_form = params["title"]
      author = @author_form.present? ? "inauthor:#{sanitize(@author_form)}" : ""
      title = sanitize(@title_form)
      url = build_url(author, title)
    
      response = client.send_request(method: :get, url: url, event: "SEARCH")
      @books = response.body["items"]
    end
  end

  private

  def client
    @client ||= GoogleBooks::Client.new
  end

  def build_url(author, title)
    BASE_URL + "?q=" + title + "&" + author + "&printType=books"
  end

  def sanitize(text)
    text.parameterize(separator: '+')
  end
end
