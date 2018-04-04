require_relative "Task_holder.rb"
require "date"
class Input
	def initialize
		@holder = Task_holder.new
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
		else
			fechas = string.split("/")
			return Date.new(fecha[-1],fecha[-2],fecha[-3])
		end
	end

	def input_check(input)
		if (/^add [a-zA-Z]+|\+/ =~ input) #add con grupo y desc
			if (/^add \+[a-zA-Z]+ ([a-zA-Z]+|\s)+$/ =~ input)
				arr = input.split(/\s+/)
				group=arr[1]
				desc=generate_desc(arr)
				id = @holder.add(desc,nil,group)
				show_add_message(id,desc)
			elsif(/^add ([a-zA-Z]+|\s)+$/ =~ input) #add solo desc
				arr = input.split(/\s+/)
				desc = generate_desc(arr)
				id = @holder.add(desc)
				show_add_message(id,desc)
			elsif (/^add ([a-zA-Z]+|\s)+ due (tomorrow|today|[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9][0-9][0-9])\s*$/ =~ input) #add con fecha y desc
				arr = input.split(/\s+/)
				date = to_date(arr[-1])
				desc = generate_desc(arr)
				id = @holder.add(desc,date)
				show_add_message(id,desc)
			elsif(/^add \+[a-zA-Z]+ ([a-zA-Z]+|\s)+ due (tomorrow|today|[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9][0-9][0-9])\s*$/ =~ input) #add con los tres
				arr = input.split(/\s+/)
				group = arr[1]
				date = to_date(arr[-1])
				desc = generate_desc(arr)
				id = @holder.add(desc,date,group)
				show_add_message(id, desc)
			else
				show_error
			end
		elsif (/^list/ =~ input)
			if (/^list due (today|tomorrow|this-week)\s*$/ =~ input) #lsit con fecha
				puts "All"
				arr = input.split(/\s+/)
				@holder.list_due(arr[-1])
				#FALTA LO DE puts task.to_s
			elsif(/^list group\s*$/ =~ input) #list en grupos
				@holder.list_group
				#FALTA LO DE puts task.to_s_by_group
			elsif(/^list overdue\s*$/ =~ input) #list de las vencidas
				@holder.list_overdue
				#FALTA LO DE puts task.to_s
			elsif(/^list\s*$/ =~ input) #list solo
				puts "All"
				@holder.list
				#FALTA LO DEL each
			elsif(/^list \+[a-zA-Z]+\s*$/ =~ input) #list en grupo especifico
				arr = input.split(/\s+/)
				@holder.list_by_group(arr[-1])
				puts "#{arr[-1]}"
				#FALTA LO DE puts task.to_s_by_group
			else
				show_error
			end		
		elsif(/^ac\s*$/ =~ input) #archivar
			@holder.ac
		elsif(/^complete [0-9]+\s*$/ =~ input) #completar tarea
			arr = input.split(/\s+/)
			description = @holder.complete(arr[1].to_i)
			puts "Todo [#{arr[1]}: #{description}] completed."
		elsif(/^save \w+\S$/ =~ input) #guardar archivo
			arr = input.split(/\s+/)
			holder.savefile(arr[1])
		elsif(/^open \w+\S$/ =~ input) #abrir archivo
			arr = input.split(/\s+/)
			@holder.load(arr[1])
		elsif(/^find [a-zA-Z0-9]+\s*$/ =~ input) #buscar
			arr = input.split(/\s+/)
			@holder.find(arr[1])
			#FALTA LO DE MOSTRAR LA/S TAREA/S
		elsif(/^set/ =~ input) 
			if(/^set date_task (tomorrow|today|[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9][0-9][0-9])*\s*/ =~ input) #set default fecha
				arr = input.split(/\s+/)
				if(arr[-1] != 'date_task')
					@holder.set_date(to_date(arr[-1]))
				else
					@holder.set_date(nil)
				end
			elsif(/^set group [a-zA-Z]*\s*$/ =~ input) #set default grupo
				arr = input.split(/\s+/)
				if(arr[-1] != 'set')
					@holder.set_group(arr[-1])
				else
					@holder.set_group("")
				end
			else
				show_error
			end
		elsif(/^help\s*$/ =~ input)
			@holder.help
		else
			show_error
		end
	end
end

command_line = Input.new
input = gets.chomp
while (input !~ /^exit\s*$/) do
	command_line.input_check(input)
	input = gets.chomp
end
