class Weathercli::CLI

	def usage
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

	def call
		start
	end

	def start
		arg = "x"
		arg =  ARGV[0].gsub("-","") if ARGV[0]

		week = Week.new

		case arg
		when 'x'
			puts "------------------------------"
			puts "Today's weather"
			week.today.printlite
			puts "------------------------------"
			puts "Tomorrow's weather"
			week.tomorrow.printlite
			puts "------------------------------"
		when 't'
			puts "Tomorrow's weather"
			week.tomorrow.printlite
			puts "------------------------------"
		when 'td'
			week.tomorrow.print
		when 'n'
			puts "------------------------------"
			puts "Today's weather"
			week.today.printlite
			puts "------------------------------"
		when 'nd'
			week.today.print
		when 'w'
			index = week.week.index( week.tomorrow.day ) + 1
			count = 0
			puts "------------------------------"
			puts "Today's weather"
			week.today.printlite
			puts "------------------------------"
			puts "Tomorrow's weather"
			week.tomorrow.printlite
			while count < 5
				week.days[(index)%7].printlite
				index += 1
				count += 1
			end
		when 'wd'
			index = week.week.index( week.tomorrow.day ) + 1
			count = 0
			week.today.print
			week.tomorrow.print
			while count < 5
				week.days[(index)%7].print
				index += 1
				count += 1
			end
		when 'h'
			usage
		when 'help'
			usage
		else
			puts "Invalid input, please use -h or --help for help"
		end
	end
end

