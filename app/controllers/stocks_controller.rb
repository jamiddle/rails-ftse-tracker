require 'open-uri'
require 'nokogiri'

class StocksController < ApplicationController
  def new
    @stock = Stock.new
  end

  def create
    @stock = Stock.new(stock_params)
  end

  def index
    scrape
    create
    assign_stocks
    @stocks = Stock.all
  end

  def show
  end

  def edit
  end

  def update
  end

  def scrape
    @names = []
    @each_last_price = []
    @each_change = []
    @each_percentage_change = []
    @each_market_cap = []

    @html_doc = Nokogiri::HTML(open('https://www.sharecast.com/index/FTSE_100').read)
    @html_doc.search('.ttl a').children.each do |name|
      @names << name.text
    end
  end

  def assign_stocks
    @stocks = Stock.all
    @stocks.zip(@names).each do |stock, name|
      stock.name = name
    end
  end

  private

  def stock_params
    params.permit(:name, :last_price, :change, :percentage_change, :market_cap)
  end
end
