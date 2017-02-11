require_relative "../../config/environment.rb"

class Scraper

  URL = "http://www.multpl.com/s-p-500-historical-prices/table/by-month"

  def self.webpage_to_html
    Nokogiri::HTML(open(URL)).css("table#datatable tr")
  end

  def self.string_to_date(string)
    # month = 0
    data_array = string.split(/,|\s/).select{ |s| !s.strip.empty? }
    case data_array[0]
    when "Jan"
      month = 1
    when "Feb"
      month = 2
    when "Mar"
      month = 3
    when "Apr"
      month = 4
    when "May"
      month = 5
    when "Jun"
      month = 6
    when "Jul"
      month = 7
    when "Aug"
      month = 8
    when "Sep"
      month = 9
    when "Oct"
      month = 10
    when "Nov"
      month = 11
    when "Dec"
      month = 12
    end
    Date.new(data_array[2].to_i, month, data_array[1].to_i)
  end

  def self.array_to_datapoints
    # new_data_points = []
    webpage_to_html.reverse.each_with_index do |row, index|
      price = row.css("td.right").text.gsub(",","").to_f
      date = row.css("td.left").text
      # binding.pry
      if price > 0.0 && !date.empty?
        dp = DataPoint.new
        dp.id = index
        dp.date = string_to_date(date)
        dp.price = price
        if DataPoint.all[index-1].price > 0.0
          dp.monthly_change = price - DataPoint.all[index-1].price
        end
        if !DataPoint.all[index-12].nil? && DataPoint.all[index-12].price > 0.0
          dp.yearly_change = price - DataPoint.all[index-12].price
        end
        # new_data_points << dp
      end
    end
    nil
  end

end