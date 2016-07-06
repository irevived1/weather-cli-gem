require_relative '../lib/weather.rb'

arg = "x"
arg =  ARGV[0].gsub("-","") if ARGV[0]


case arg
when 'x'
weather = Weather.new
	weather.twoDayForecast
when 't'
weather = Weather.new
	weather.tomorrow
when 'td'
weather = Weather.new
	weather.tomorrowInfo
when 'n'
weather = Weather.new
	weather.today
when 'nd'
weather = Weather.new
	weather.todayInfo
when 'w'
weather = Weather.new
	weather.sevenDayForecast
when 'wd'
weather = Weather.new
	weather.sevenDayInfo
when 'h'
when 'help'
weather = Weather.new
	weather.help
else
	puts "Invalid input, please use -h or --help for help"
end
