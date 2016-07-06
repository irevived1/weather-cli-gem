require 'open-uri'
require 'nokogiri'
require 'pry'

#class for scrapper, no need to initialize
class Scraper
	@@doc = nil
	@@symb = '°'
	def self.scrape_page(url)
		@@doc = Nokogiri::HTML(open(url))
		#binding.pry 
	end

=begin
	#returns current status for today and high/low temperature
	#as an array
	def self.today
		if @@doc == nil
			begin
				raise ScraperError
			rescue ScraperError => error
				error.message
			end
		else
			#today, status
			status = @@doc.css("span.description").text
			#today, high-low
			highlow = @@doc.css("div.high-low").text.split(@@symb)
			highlow.map! { |x| x = x + @@symb }
			[status, highlow].flatten
		end
	end
=end
	
	#stores the next 6 days of the forecast and returns an array
	def self.otherdays
		if @@doc == nil
			begin
				raise ScraperError
			rescue ScraperError => error
				puts error.message
			end
		else
			days = []
			#other days
			#index error
			#(0..5).to_a.each do | i |
			(0..6).to_a.each do | i |
				#some regex to make the string look pretty
				tmp =  @@doc.css("div.BdB")[i].text.sub(/day\d*%/, 'day, High:' )
				tmp = tmp.sub(@@symb , @@symb + 'Low:')
				tmp = tmp.sub(@@symb , @@symb + ' ')
				tmp[tmp.index(/°\S/)] = @@symb + ' --- '
				days << tmp
			end
			return days
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
