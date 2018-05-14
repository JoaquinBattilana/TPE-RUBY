class SetQuery
	DATE = 1
	GROUP = 2

	def initialize(holder, query)
		@holder = holder
		@text = query
		@set_id = parse
	end

	def execute
		case @set_id
		when DATE
			arr = @text.split(/\s+/)
			if(arr[-1] != 'date_task')
				@holder.set_date(to_date(arr[-1]))
				puts "Date set to #{arr[-1]}"
			else
				@holder.set_date(nil)
				puts "Fixed-date removed"
			end
		when GROUP
			if(/^set group \+[a-zA-Z]+/ =~ @text)
				arr = @text.split(/\s+/)
				@holder.set_group(arr[-1])
				puts "Group set to #{arr[-1]}"
			else
				@holder.set_group("")
				puts "Fixed-group removed"
			end
		end
	end

	def parse
		if(/^set date_task(\stomorrow|\stoday|\s[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9][0-9][0-9])*\s*/ =~ @text) #set default fecha
			return DATE
		elsif(/^set group/ =~ @text) #set default grupo
			return GROUP
		else
			show_error
		end
	end

	def to_date(string)
		if (string == "today")
			return Date.today 
		elsif (string == "tomorrow")
			return (Date.today+1)
		elsif (string == "this-week")
			return (Date.today+7)
		else
			fechas = string.split("/")
			return Date.new(fechas[-1].to_i,fechas[-2].to_i,fechas[-3].to_i)
		end
	end

	def show_error
		puts 'Invalid command. Use help for command list'
	end

end