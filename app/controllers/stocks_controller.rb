require 'open-uri'
require 'nokogiri'

class StocksController < ApplicationController

  def new
    @stock = Stock.new
  end

  def create
    @names.each do |name|
      @stock = stock.new(name: name)
    end
    if @stock.save
      redirect_to stock_path
      puts 'the stock saved'
    end
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
