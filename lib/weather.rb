require 'day.rb'
require 'scraper'

#global URL for access
$url = "https://www.yahoo.com/news/weather"

class Weather
	#static variable for weeks, weeks dont change
	@@week = [ "Monday" , "Tuesday" , "Wednesday" , "Thursday" , "Friday" , "Saturday" , "Sunday" ]
	attr_reader :monday ,:tuesday ,:wednesday ,:thursday ,:friday ,:saturday ,:sunday ,:today, :tomorrow
	#massive initialize function
	def initialize
		Scraper.scrape_page($url)
		
	end
end
