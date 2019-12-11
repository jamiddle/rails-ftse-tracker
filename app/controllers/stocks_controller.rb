require 'open-uri'
require 'nokogiri'

class StocksController < ApplicationController
  def new
    @stock = stock.new
    url = "https://lsemarketcap.com/"

    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)

    @symbol = html_doc.search(".smw-market-data-field a").innerHTML
  end

  def create
  end

  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  def scrape
    url = "https://lsemarketcap.com/"

    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)

    html_doc.search(".smw-table")
  end

  private

  def stock_params
  end
end
