class Day
	
	#getter and setter macros
	attr_accessor :day , :high , :low , :status, :info

	#initialize with mass assign
	def initialize(attr)
		attr.each do |k , v|
			k = self.send("#{k}=", v )
		end
	end

	#simple print statements
	def print
		puts "------------------------------"
		(puts "Day of the week: " + @day) if @day
		if ( @day && @status )
			puts @day + " - " + @status
		end
		(puts "Info: " + @info) if @info
		puts "------------------------------"
	end

	#prints light version of info
	def printlite
		puts "------------------------------"
		if ( @day && @status )
			puts @day + " - " + @status
		end
		if ( @high && @low )
			puts @high + "\t" + @low
		end
		puts "------------------------------"
	end

end

