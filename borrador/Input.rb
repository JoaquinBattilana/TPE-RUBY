require_relative "Task_holder.rb"
require "date"
class Input
	FULL_ADD = 1
	ADD_DATE_DESC = 2
	ADD_GROUP_DESC = 3
	ADD_DESC = 4

	def initialize
		@holder = TaskHolder.new
	end

	def show_add_message(id, description)
		puts "Todo [#{id}: #{description}] added."
	end

	def to_s
		'Error'
	end

	def show_error
		puts 'Invalid command. Use help for command list'
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

	def input_check(input)
		if (/^add/ =~ input) #add con grupo y desc
			add_parser(input)
		elsif (/^list/ =~ input)
			list_parser(input)	
		elsif(/^ac\s*$/ =~ input) #archivar
			@holder.ac
			puts "All completed task has been archived."
		elsif(/^complete [0-9]+\s*$/ =~ input) #completar tarea
			complete_parser(input)
		elsif(/^save \w+\S$/ =~ input) #guardar archivo
			save(input)
		elsif(/^open \w+\S$/ =~ input) #abrir archivo
			open_file(input)
		elsif(/^find [a-zA-Z0-9]+\s*$/ =~ input) #buscar
			arr = input.split(/\s+/)
			puts @holder.find(arr[1])
		elsif(/^set/ =~ input) 
			set_parser(input)
		elsif(/^help\s*$/ =~ input)
			help
		else
			show_error
		end
	end

	def load(text)
		begin
			arr = text.split(/\s+/)
			@holder.load(arr[-1])
			puts "File was loaded"
		rescue Exception => e
			puts e.message
		end
	end

	def add_parser(input)
		if(/^add \+[a-zA-Z]+ ([a-zA-Z0-9]+|\s)+ due (tomorrow|today|[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9][0-9][0-9])\s*$/ =~ input) #add desc date and group
			add(FULL_ADD, input)
		elsif (/^add ([a-zA-Z0-9]+|\s)+ due (tomorrow|today|[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9][0-9][0-9])\s*$/ =~ input) #add date y desc
			add(ADD_DATE_DESC, input)
		elsif (/^add \+[a-zA-Z]+ ([a-zA-Z0-9]+|\s)+$/ =~ input) #add group and desc
			add(ADD_GROUP_DESC, input)
		elsif(/^add ([a-zA-Z0-9]+|\s)+$/ =~ input) #add desc
			add(ADD_DESC, input)
		else
			show_error
		end
	end

	def add(state,input)
		case state
		when FULL_ADD
			arr = input.split(/\s+/)
			group = arr[1]
			date = to_date(arr[-1])
			desc = generate_desc(arr)
			id = @holder.add(desc,date,group)
			show_add_message(id, desc)
		when ADD_DATE_DESC
			arr = input.split(/\s+/)
			date = to_date(arr[-1])
			desc = generate_desc(arr)
			id = @holder.add(desc,date)
			show_add_message(id,desc)
		when ADD_GROUP_DESC
			arr = input.split(/\s+/)
			group=arr[1]
			desc=generate_desc(arr)
			id = @holder.add(desc,nil,group)
			show_add_message(id,desc)
		when ADD_DESC
			arr = input.split(/\s+/)
			desc = generate_desc(arr)
			id = @holder.add(desc)
			show_add_message(id,desc)
		end
	end

	def list_parser(input)
		if(/^list \+[a-zA-Z]+$/ =~ input) #list specific group
			arr = input.split(/\s+/)
			puts "#{arr[-1]}"
			(@holder.list_by_group(arr[-1])).each {|task| puts task.to_s_without_group}
		elsif (/^list due (today|tomorrow|this-week)\s*$/ =~ input) #lsit con fecha
			puts "All"
			arr = input.split(/\s+/)
			puts @holder.list_due(to_date(arr[-1]))
		elsif(/^list group\s*$/ =~ input) #list all groups
			a=@holder.list_group
			a.each do |group|
			puts group
			(@holder.list_by_group(group)).each {|task| puts task.to_s_without_group}
			end
		elsif(/^list overdue\s*$/ =~ input) #list overdue
			puts "All"
			puts @holder.list_overdue
		elsif(/^list\s*$/ =~ input) #list all
			puts "All"
			puts @holder.list
		else
			show_error
		end	
	end

	def complete_parser(input)
		arr = input.split(/\s+/)
		task = @holder.find_task_by_id(arr[1].to_i)
		if task==nil
			puts "Invalid Task"
		elsif @holder.complete(task)
			puts "Todo [#{arr[1]}: #{task.description}] completed."
		else
			puts "Task #{arr[1]} already completed"
		end
	end

	def save(input)
		begin
			arr = input.split(/\s+/)
			@holder.save(arr[-1])
			puts "File was saved"
		rescue Exception => e
			e.message
		end
	end

	def open_file(input)
		if(!(@holder.isEmpty?))
			puts "Are you sure you want to overwrite? Y/N"
			conf = gets.chomp
			if(conf == "Y")
				load(input)
			else
				puts "Command not executed"
			end
		else
			load(input)
		end
	end

	def set_parser(input)
		if(/^set date_task(\stomorrow|\stoday|\s[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9][0-9][0-9])*\s*/ =~ input) #set default fecha
			arr = input.split(/\s+/)
			if(arr[-1] != 'date_task')
				@holder.set_date(to_date(arr[-1]))
				puts "Date set to #{arr[-1]}"
			else
				@holder.set_date(nil)
				puts "Fixed-date removed"
			end
		elsif(/^set group/ =~ input) #set default grupo
			if(/^set group \+[a-zA-Z]+/ =~ input)
				arr = input.split(/\s+/)
				@holder.set_group(arr[-1])
				puts "Group set to #{arr[-1]}"
			else
				@holder.set_group("")
				puts "Fixed-group removed"
			end
		else
			show_error
		end
	end

	def help()
		puts "add - Adds another task; options include:\n\t[GROUP_NAME] - Name of the group where the task will be; Format: +[GROUP_NAME]\n\t[DESCRIPTION] - A text that describes the task\n\tdue [DATE] - Date where the task is due; Format: DD/MM/YYYY

list - List all tasks; if no parameters ar given, lists all tasks with/without groups and with/without date; options include:\n\t[GROUP_NAME] - List a specific group; Format: +[GROUP_NAME]\n\tdue [DATE] - Lists all due tasks; Format: today | tomorrow | this-week\n\tgroup - Lists all tasks with its group\n\toverdue - Lists all overdue tasks

ac - Archives all completed tasks

complete - complete a task; options include:\n\t[DESCRIPTION] - Description of the task to complete

save - saves all tasks in a file; options include:\n\t[FILE_NAME] - Name of the file to save

open - opens a file with tasks; options include:\n\t[FILE_NAME] - Name of the file to open

find - finds a task that contains the text received; options include:\n\t[TEXT] - Text to find on the tasks

set - sets a default date or group; if no parameters are given, removes default date/group; options include:\n\tdate_task [DATE] - Default date to add; Format: DD/MM/YYYY\n\tgroup [GROUP_NAME] - Default group to add; Format: +[GROUP_NAME]"
	end

	def start()
		while((input=gets.chomp)!='exit')
			input_check(input)
		end
	end
end
