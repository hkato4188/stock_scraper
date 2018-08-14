class StockScraper::Stock
  attr_accessor :symbol, :name, :last_price, :market_time, :change_percent

  def self.scrape_yahoo
    doc = Nokogiri::HTML(open("https://finance.yahoo.com/trending-tickers/"))
    scraped_stocks = []
    doc.css("tbody tr").each do |column|
      stock_obj = self.new
      stock_obj.symbol = column.css("td.data-col0")[0].children[0].values[2]
      stock_obj.name = column.css("td.data-col0")[0].children[0].values[1]
      stock_obj.last_price = column.css("td.data-col2")[0].children.inner_text
      stock_obj.market_time = column.css("td.data-col3")[0].children.inner_text
      stock_obj.change_percent = column.css("td.data-col5")[0].children.inner_text
      scraped_stocks << stock_obj
    end
    scraped_stocks
  end
end
