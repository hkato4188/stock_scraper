
class StockScraper::CLI

  def call
    list_stocks
    menu
    goodbye
  end

  def list_stocks
    puts "Today's popular trending stocks are:"
    StockScraper::Stock.clear
    update_stocks
    StockScraper::Stock.all.each.with_index(1) do |stock, i|
      puts "#{i}. #{stock.name}"
    end
  end

  def update_stocks
    StockScraper::Scraper.scrape_yahoo
  end

  def menu
    input = nil
    while input != "exit"
      puts "Enter the number of the stock you would like more information on or type list to see more stocks or type exit"
      input = gets.strip.downcase
      if input.to_i > 0 && input.to_i - 1 < StockScraper::Stock.all.length
        StockScraper::Stock.clear
        update_stocks
        the_stock = StockScraper::Stock.all[input.to_i - 1]
        puts ""
        puts "Stock Name: #{the_stock.name} - Symbol: #{the_stock.symbol}"
        puts "Last Price: $#{the_stock.last_price} - Market Time: #{the_stock.market_time} - Change Percent: #{the_stock.change_percent}"
        puts ""
      elsif input == "list"
        list_stocks
      elsif input == "exit"
        puts ""
        puts "Thank you for using the stock_scraper gem"
      elsif  input.to_i >= StockScraper::Stock.all.length - 1
        puts ""
        puts "Sorry, that number does not correspond with a stock and therefore is not a valid option"
        puts "Please type 'list' or 'exit'"
        puts ""
      else
        puts ""
        puts "I am not sure what you are requesting; please enter a valid command:"
        puts "Type list to see today's trending stocks"
        puts "Type exit if you would like leave"
        puts ""
      end
    end
  end

  def goodbye
    puts "See you tomorrow for more stock information"
    puts "Happy trading!"
    puts ""
  end

end
