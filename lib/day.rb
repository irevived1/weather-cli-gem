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
		(puts "Day of the week: " + @day) if @day
		(puts "High: " + @high) if @high
		(puts "Low: " + @low) if @low
		(puts "Status: " + @status) if @status
		(puts "More information: " + @info) if @info
	end
end
