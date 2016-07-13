require 'open-uri'
require 'nokogiri'
require 'pry'

#class for scrapper, no need to initialize
class Scraper
	@@url = "https://www.yahoo.com/news/weather"
	@@symb = '°'
	@doc = nil
	@weather
	def initialize(weather)
		@weather = weather
	end
	
	def scrape_page
		@doc = Nokogiri::HTML(open(@@url))
		refresh
	end
	
	def otherdays
		if @doc == nil
			begin
				raise ScraperError
			rescue ScraperError => error
				puts error.message
			end
		else
			parse_raw_string_data
		end
	end

	def reset
		@weather.tomorrow = nil
		@weather.today = nil
		#initialize an array for days
		@weather.days = Array.new(7,nil)
	end
	
	def parse_day_high_low(string)
			day_high_low = string.split(" ")
			tmp = {}
			tmp[:day] = day_high_low[0].match(/^[a-zA-Z]*day/).to_s
			tmp[:high] = day_high_low[1]
			tmp[:low] = day_high_low[2]
			tmp
	end

	def parse_status_info(hash,string)
			status = string.split(" ")
			status = status[0..1].join(" ")
			status = status.gsub(/(today)|(with)/,"").strip
			hash[:status] = status
			hash[:info] = string
			hash
	end

	def get_attribute(string)
		parts = string.split(' --- ')
		tmp = parse_day_high_low(parts[0])
		tmp = parse_status_info(tmp,parts[1])
		tmp
	end

	def refresh
		reset
		otherdays.each do |day|
			#massive string parsing to store into Day class
			tmp = get_attribute(day)

			#store them into day
			index = @weather.week.index(tmp[:day])
			@weather.days[index] = Day.new(tmp)

			#filling in today and tomorrow
			@weather.tomorrow = @weather.days[index] if (@weather.today != nil && @weather.tomorrow == nil)
			@weather.today = @weather.days[index] if @weather.today == nil
		end
	end

	def parse_raw_string_data
		(0..6).to_a.collect do | i |   #some regex to make the string look pretty
			tmp = @doc.css("div.BdB")[i].text.sub(/day\d*%/, 'day, High:' )
			tmp = tmp.sub(@@symb , @@symb + 'Low:')
			tmp = tmp.sub(@@symb , @@symb + ' ')
			tmp[tmp.index(/°\S/)] = @@symb + ' --- '
			tmp
		end
	end

	#warning messages
	class ScraperError < StandardError
		def message
			"Error: Please call the method #scrape_page before using other functions"
		end
	end

end

#url = "https://www.google.com/search?q=google+weather"
#url = "https://www.wunderground.com/cgi-bin/findweather/getForecast?query=11204"
#url = "https://www.yahoo.com/news/weather"
#Scraper.scrape_page(url)
#puts Scraper.today
#puts Scraper.otherdays
