
class StockScraper::CLI

  def call
    list_stocks
    menu
    goodbye
  end

  def list_stocks
    puts "Today's popular trending stocks are:"
    update_stocks
    @stocks.each.with_index(1) do |stock, i|
      puts "#{i}. #{stock.name}"
    end
  end

  def update_stocks
    @stocks = StockScraper::Stock.scrape_yahoo
  end

  def menu
    input = nil
    while input != "exit"
      puts "Enter the number of the stock you would like more information on or type list to see more stocks or type exit"
      input = gets.strip.downcase
      if input.to_i > 0 && input.to_i - 1 < @stocks.length
        update_stocks
        the_stock = @stocks[input.to_i - 1]
        puts ""
        puts "Stock Name: #{the_stock.name} - Symbol: #{the_stock.symbol}"
        puts "Last Price: $#{the_stock.last_price} - Market Time: #{the_stock.market_time} - Change Percent: #{the_stock.change_percent}"
        puts ""
      elsif input == "list"
        list_stocks
      elsif input == "exit"
        puts "Happy trading!"
      elsif  input.to_i >= @stocks.length - 1
        puts "Not sure what stock you are requesting, type list or exit"
      else
        puts "you have found a vulnerability; hacking into the main frame!"
      end
    end
  end

  def goodbye
    puts "See you tomorrow for more stock information"
  end

end
