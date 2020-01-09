require 'open-uri'
require 'nokogiri'

class StocksController < ApplicationController
  def new
    @stock = Stock.new
  end

  def create
    100.times do
      @stock = Stock.new(stock_params)
      @stock.save
    end
  end

  def index
    @stocks.destroy_all if @stocks
    scrape
    create
    @stocks = Stock.all
    assign_stocks
  end

  def show
  end

  def edit
  end

  def update
  end

  private

  def scrape
    @names = []
    @prices = []
    @changes = []
    @percentage_changes = []
    @market_caps = []

    @html_doc = Nokogiri::HTML(open('https://www.sharecast.com/index/FTSE_100').read)
    @html_doc.search('.ttl a').children.first(100).each do |name|
      @names << name.text
    end
    @html_doc.search('.price-ttl span').children.first(100).each do |price|
      @prices << price.text.delete_suffix('p').gsub(/[^\d^.]/, '').to_f
    end
    @html_doc.search('.Chg-ttl span').children.first(100).each do |percentage_change|
      @percentage_changes << percentage_change.text.delete_suffix('%').to_f
    end
  end

  def assign_stocks
    @stocks.zip(@names, @prices, @percentage_changes).each do |stock, name, price, percentage_change|
      stock.name = name
      stock.last_price = price
      stock.percentage_change = percentage_change
    end
  end

  def stock_params
    params.permit(:name, :last_price, :change, :percentage_change, :market_cap)
  end
end
