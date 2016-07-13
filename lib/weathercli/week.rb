require 'pry'
require_relative 'day.rb'
require_relative 'scraper.rb'

class Week
	#static variable for weeks, weeks dont change
	@@week = [ "Monday" , "Tuesday" , "Wednesday" , "Thursday" , "Friday" , "Saturday" , "Sunday" ]
	attr_accessor :tomorrow, :today , :days
	#today tomorrow and days(with 7 days)

	def week
		@@week
	end

	def initialize
		@scrap = Scraper.new(self)
		if (days == nil)
			refresh
		end
	end

	def refresh
		@scrap.scrape_page
	end
end
