require 'open-uri'
require 'nokogiri'

class StocksController < ApplicationController

  def new
    @stock = stock.new
  end

  def create
    @stock = Stock.new(stock_params)
    @stock.name = @names.first
    @stock.save
  end

  def index
    scrape
    @stocks = Stock.all
    @names
  end

  def show
  end

  def edit
  end

  def update
  end

  def scrape
    @names = []
    @html_doc = Nokogiri::HTML(open("https://www.sharecast.com/index/FTSE_100").read)
    @html_doc.search(".ttl a").children.each do |name|
      @names << name.text
    end
  end

  private

  def stock_params
    params.require(:stock).permit(:symbol, :name, :last_price, :change, :percentage_change, :market_cap)
  end
end
