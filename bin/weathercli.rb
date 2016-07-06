#!/usr/local/bin/ruby
require_relative '../lib/weather.rb'

arg = "x"
arg =  ARGV[0].gsub("-","") if ARGV[0]

weather = Weather.new

case arg
when 'x'
	weather.twoDayForecast
when 't'
	weather.tomorrow
when 'td'
	weather.tomorrowInfo
when 'n'
	weather.today
when 'nd'
	weather.todayInfo
when 'w'
	weather.sevenDayForecast
when 'wd'
	weather.sevenDayInfo
when 'h'
	weather.help
when 'help'
	weather.help
else
	puts "Invalid input, please use -h or --help for help"
end
