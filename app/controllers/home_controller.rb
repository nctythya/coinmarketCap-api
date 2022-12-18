require "json"
require "open-uri"

class HomeController < ApplicationController
  def index
  end

  def about
  end

  def lookup
    url = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=#{ENV['API_KEY']}"
    #url = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=9da0f106-d8b3-4138-865c-09975e3c1f58"
    uri = URI.open(url).read
    @tickers = JSON.parse(uri)

    @symbol = params[:query]
    if @symbol
      @symbol = @symbol.upcase
    end
  end
end
