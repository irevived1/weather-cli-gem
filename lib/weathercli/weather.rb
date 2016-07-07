require 'pry'
require_relative 'day.rb'
require_relative 'scraper.rb'

#global URL for access
$url = "https://www.yahoo.com/news/weather"

class Weather
	#static variable for weeks, weeks dont change
	@@week = [ "Monday" , "Tuesday" , "Wednesday" , "Thursday" , "Friday" , "Saturday" , "Sunday" ]
	#today tomorrow and days(with 7 days)
	#attr_reader :today, :tomorrow, :days
	#massive initialize function
	def initialize
		refresh
	end

	def refresh
		@tomorrow = nil
		@today = nil
		#initialize an array for days
		@days = Array.new(7,nil)
		Scraper.scrape_page($url)

=begin
		#gets information for today
		tmp = { }
		arr = Scraper.today
		tmp[:high] = "High:" + arr[1]
		tmp[:low] = "Low:" + arr[2]
		tmp[:status] = arr[0]
		tmp[:info] = "Need information? Look outside the window!"
		#variable today is all good except for getting day of the week
		@today = Day.new(tmp)
=end
		#index of the week
		index = nil
		the_other_6_days = Scraper.otherdays
		the_other_6_days.each do |day|
			#massive string parsing to store into Day class
			#split into parts
			parts = day.split(' --- ')

			#first part contains the day, high and low
			day_high_low = parts[0].split(" ")
			tmp = {}
			tmp[:day] = day_high_low[0].match(/^[a-zA-Z]*day/).to_s
			tmp[:high] = day_high_low[1]
			tmp[:low] = day_high_low[2]

			#second part with status and infomration
			status = parts[1].split(" ")
			#get first two letters
			status = status[0..1].join(" ")
			#if theres the word "today", remove it
			status = status.gsub("today","").strip
			tmp[:status] = status
			tmp[:info] = parts[1]

			#store them into day
			index = @@week.index(tmp[:day])

			@days[index] = Day.new(tmp)

			#filling in today and tomorrow
			@tomorrow = @days[index] if (@today != nil && @tomorrow == nil)
			@today = @days[index] if @today == nil
			
		end
	end

	#prints today's weather
	def today
		puts "------------------------------"
		puts "Today's weather"
		@today.printlite
		puts "------------------------------"
	end

	#prints tomorrow's weather
	def tomorrow
		puts "Tomorrow's weather"
		@tomorrow.printlite
		puts "------------------------------"
	end

	#prints two days 
	def twoDayForecast
		today
		tomorrow
	end

	#prints seven days in advance
	def sevenDayForecast
		index = @@week.index( @tomorrow.day ) + 1
		count = 0
		twoDayForecast
		while count < 5
			@days[(index)%7].printlite
			index += 1
			count += 1
		end
	end

	#prints today's weather in detail
	def todayInfo
		@today.print
	end

	#prints tomorrow's weather in detail
	def tomorrowInfo
		@tomorrow.print
	end

	#prints seven days in detail
	def sevenDayInfo
		index = @@week.index( @tomorrow.day ) + 1
		count = 0
		todayInfo
		tomorrowInfo
		while count < 5
			@days[(index)%7].print
			index += 1
			count += 1
		end
	end

	def help
		puts "USEAGE"
		puts "---------------\n"
		puts "This program defaults to two-day forecast if no argument is provided."
		puts "\nTo use the available arguments, please look at the flags below.\n"
		puts "-t\t\tPrints the weather for tomorrow.\n"
		puts "-n\t\tPrints the weather for today.\n"
		puts "-w\t\tPrints the weather for the whole week.\n"
		puts "-d\t\tAdd this flag behind the others for detail information. eg: -td , -nd, -wd..\n"
		puts "-h or --help for help"
	end
end

#weather = Weather.new
#weather.today
