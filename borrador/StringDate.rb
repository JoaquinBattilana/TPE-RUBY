require "date"

class StringDate
	attr_reader :description,:date
	
	@@PREDEFINED_DATES={"yesterday"=>Date.today-1, "tomorrow"=>Date.today+1, "today"=>Date.today}
	
	def initialize(date)
		@description=date
		if(@@PREDEFINED_DATES.has_key?(date))
			@date=@@PREDEFINED_DATES[date]
		else
			@date=Date.strptime(date, '%d/%m/%Y')
		end
	end
	def to_s
		@description
	end
	def ==(other)
		@date==other.date
	end
	def <=>(other)
		@date<=>other.date
	end
end
