class BooksController < ApplicationController
  BASE_URL = ENV.fetch "GOOGLE_BOOKS_URL"

  # TODO: what parts of the page are going to be for authenticated users
  # before_action :authenticate_user!

  def index
    @books = []

    if search_params
      @title_form = search_params
      title = sanitize(@title_form)
      url = build_url(title)
    
      response = client.send_request(method: :get, url: url, event: "SEARCH")
      @books = response.body["items"]
    end
  end

  private

  def client
    @client ||= GoogleBooks::Client.new
  end

  def build_url(title)
    BASE_URL + "?q=" + title + "&printType=books"
  end

  def sanitize(text)
    text.parameterize(separator: '+')
  end

  def search_params
    params["title"]
  end
end
