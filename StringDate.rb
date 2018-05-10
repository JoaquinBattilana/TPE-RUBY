require "date"

class StringDate
	attr_reader :description,:date
	
	@@PREDEFINED_DATES={"yesterday"=>Date.today-1, "tomorrow"=>Date.today+1, "today"=>Date.today,"this_week"=>Date.today+7}
	
	def initialize(string)
		if(@@PREDEFINED_DATES.has_key?(string))
			@date=@@PREDEFINED_DATES[string]
		else
			@date=Date.strptime(string, '%d/%m/%Y')
		end
	end
	def to_s
		if (@date== Date.today)
			return "today"
		elsif (@date==(Date.today+1))
			return "tomorrow"
		else
			return @date.day+"/"+@date.month+"/"+@date.year
		end
	end
	def ==(other)
		@date==other.date
	end
	def <=>(other)
		@date<=>other.date
	end
end
