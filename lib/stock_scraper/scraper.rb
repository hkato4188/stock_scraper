class StockScraper::Scraper
  def self.scrape_yahoo
    doc = Nokogiri::HTML(open("https://finance.yahoo.com/trending-tickers/"))
    doc.css("tbody tr").each do |column|
      stock_obj = StockScraper::Stock.new
      stock_obj.symbol = column.css("td.data-col0")[0].children[0].values[2]
      stock_obj.name = column.css("td.data-col0")[0].children[0].values[1]
      stock_obj.last_price = column.css("td.data-col2")[0].children.inner_text
      stock_obj.market_time = column.css("td.data-col3")[0].children.inner_text
      stock_obj.change_percent = column.css("td.data-col5")[0].children.inner_text
    end
  end
end
