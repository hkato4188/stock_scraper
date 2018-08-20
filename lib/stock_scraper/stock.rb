class StockScraper::Stock
  attr_accessor :symbol, :name, :last_price, :market_time, :change_percent

  @@all = []

  def initialize
    @@all << self
  end

  def self.all
    @@all
  end

  def self.clear
    @@all.clear
  end
end
