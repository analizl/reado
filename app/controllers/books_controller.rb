class BooksController < ApplicationController
  BASE_URL = ENV.fetch "GOOGLE_BOOKS_URL"

  # TODO: what parts of the page are going to be for authenticated users
  # before_action :authenticate_user!

  def index
    @books = []

    if search_params
      @title_form = search_params
      title = sanitize(@title_form)
      index = params["index"] ? params["index"].to_s : 0.to_s
      url = build_search_url(title, index)
    
      response = client.send_request(method: :get, url: url, event: "SEARCH")
      @books = response.body["items"]
    end
  end

  def show
    url = build_volume_url(params[:id])

    response = client.send_request(method: :get, url: url, event: "SEARCH")
    @book_info = response.body["volumeInfo"]
  end

  private

  def client
    @client ||= GoogleBooks::Client.new
  end

  def build_search_url(title, index)
    BASE_URL + "?q=" + title + "&printType=books&startIndex=" + index
  end

  def build_volume_url(book_id)
    BASE_URL + '/' + book_id
  end

  def sanitize(text)
    text.parameterize(separator: '+')
  end

  def search_params
    params["title"]
  end
end
