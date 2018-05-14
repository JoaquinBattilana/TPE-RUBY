require_relative "Task_holder.rb"
require "date"
class AddQuery
	FULL_ADD = 1
	ADD_DATE_DESC = 2
	ADD_GROUP_DESC = 3
	ADD_DESC = 4

	def initialize(holder,query)
		@holder = holder
		@text = query
		@add_id = parse
	end

	def execute
		case @add_id
		when FULL_ADD
			id = @holder.add(@desc,@date,@group)
			show_add_message(id, @desc)
		when ADD_DATE_DESC
			id = @holder.add(@desc,@date)
			show_add_message(id, @desc)
		when ADD_GROUP_DESC
			id = @holder.add(@desc,nil,@group)
			show_add_message(id,@desc)
		when ADD_DESC
			id = @holder.add(@desc)
			show_add_message(id,@desc)
		end
	end

	def parse
		if(/^add \+[a-zA-Z]+ ([a-zA-Z0-9]+|\s)+ due (tomorrow|today|[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9][0-9][0-9])\s*$/ =~ @text) #add desc date and group
			begin
				set(FULL_ADD, @text)
				return FULL_ADD
			rescue Exception => e
				show_error
			end
		elsif (/^add ([a-zA-Z0-9]+|\s)+ due (tomorrow|today|[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9][0-9][0-9])\s*$/ =~ @text) #add date y desc
			begin
				set(ADD_DATE_DESC, @text)
				return ADD_DATE_DESC
			rescue Exception => e
				show_error
			end
		elsif (/^add \+[a-zA-Z]+ ([a-zA-Z0-9]+|\s)+$/ =~ @text) #add group and desc
			begin
				set(ADD_GROUP_DESC, @text)
				return ADD_GROUP_DESC
			rescue Exception => e
				show_error
			end
		elsif(/^add ([a-zA-Z0-9]+|\s)+$/ =~ @text) #add desc
			begin
				set(ADD_DESC, @text)
				return ADD_DESC
			rescue Exception => e
				show_error
			end
		else
			show_error
		end
	end

	def set(state,input)
		case state
		when FULL_ADD
			arr = input.split(/\s+/)
			@group = arr[1]
			@date = to_date(arr[-1])
			@desc = generate_desc(arr)
		when ADD_DATE_DESC
			arr = input.split(/\s+/)
			@date = to_date(arr[-1])
			@desc = generate_desc(arr)
		when ADD_GROUP_DESC
			arr = input.split(/\s+/)
			@group=arr[1]
			@desc=generate_desc(arr)
		when ADD_DESC
			arr = input.split(/\s+/)
			@desc = generate_desc(arr)
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

	def generate_desc(arg)
		arg.delete(arg[0])
		if (/\+[a-zA-Z]+$/ =~ arg[0])
			arg.delete(arg[0])
		end
		sentence = ''
		if (arg[-2] == 'due')
			arg.delete(arg[-1])
			arg.delete(arg[-1])
		end
		i=0
		until arg[i] == nil
			sentence += "#{i == 0? '': ' '}" + arg[i] 
			i+=1
		end
		return sentence 
	end

	def show_add_message(id, description)
		puts "Todo [#{id}: #{description}] added."
	end

	def show_error
		puts 'Invalid command. Use help for command list'
	end
end