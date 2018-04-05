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
		elsif (string == "this-week")
			return (Date.today+7)
		else
			fechas = string.split("/")
			return Date.new(fechas[-1].to_i,fechas[-2].to_i,fechas[-3].to_i)
		end
	end

	def input_check(input)
	#~ IMPORTANTE ANDAN MAL LAS EXPRESIONES DE ADD, SIEMPRE ENTRAN EN EL 1 Y EL 2 PERO NUNCA EN EL 3 Y EL 4
	#~ DEJE LOS PUTS DE LOS NUMEROS PARA QUE VEAN A QUE ME REFIERO!
	#~ TAMPOCO ANDA EL LIST +NOMBREDEGRUPO, TIRA SIEMPRE INVALIDO, REVISAR!!
		if (/^add [a-zA-Z]+|\+/ =~ input) #add con grupo y desc
			if(/^add \+[a-zA-Z]+ ([a-zA-Z]+|\s)+ due (tomorrow|today|[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9][0-9][0-9])\s*$/ =~ input) #add con los tres
				puts "4"
				arr = input.split(/\s+/)
				group = arr[1]
				date = to_date(arr[-1])
				desc = generate_desc(arr)
				id = @holder.add(desc,date,group)
				show_add_message(id, desc)
			elsif (/^add ([a-zA-Z]+|\s)+ due (tomorrow|today|[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9][0-9][0-9])\s*$/ =~ input) #add con fecha y desc
				puts "3"
				arr = input.split(/\s+/)
				date = to_date(arr[-1])
				desc = generate_desc(arr)
				id = @holder.add(desc,date)
				show_add_message(id,desc)
			elsif (/^add \+[a-zA-Z]+ ([a-zA-Z]+|\s)+$/ =~ input)
				puts "1"
				arr = input.split(/\s+/)
				group=arr[1]
				desc=generate_desc(arr)
				id = @holder.add(desc,nil,group)
				show_add_message(id,desc)
			elsif(/^add ([a-zA-Z]+|\s)+$/ =~ input) #add solo desc
				puts "2"
				arr = input.split(/\s+/)
				desc = generate_desc(arr)
				id = @holder.add(desc)
				show_add_message(id,desc)
			else
				show_error
			end
		elsif (/^list/ =~ input)
			if (/^list due (today|tomorrow|this-week)\s*$/ =~ input) #lsit con fecha
				puts "All"
				arr = input.split(/\s+/)
				puts @holder.list_due(to_date(arr[-1]))
			elsif(/^list group\s*$/ =~ input) #list en grupos
				a=@holder.list_group
				a.each do |group|
				puts group
				puts @holder.list_by_group(group)
				end
			elsif(/^list overdue\s*$/ =~ input) #list de las vencidas
				puts "All"
				puts @holder.list_overdue
			elsif(/^list\s*$/ =~ input) #list solo
				puts "All"
				puts @holder.list
			elsif(/^list \+[a-zA-Z]+\s*$/ =~ input) #list en grupo especifico
				arr = input.split(/\s+/)
				@holder.list_by_group(arr[-1])
				puts "#{arr[-1]}"
				puts @holder.list_by_group(arr[-1])
			else
				show_error
			end		
		elsif(/^ac\s*$/ =~ input) #archivar
			@holder.ac
			puts "Al completed task has been archived."
		elsif(/^complete [0-9]+\s*$/ =~ input) #completar tarea
			arr = input.split(/\s+/)
			task = @holder.find_task_by_id(arr[1].to_i)
			if task==nil
				puts "Invalid Task"
			elsif @holder.complete(task)
				puts "Todo [#{arr[1]}: #{task.description}] completed."
			else
				puts "Task #{arr[1]} already completed"
			end
		elsif(/^save \w+\S$/ =~ input) #guardar archivo
			begin
				arr = input.split(/\s+/)
				@holder.save(arr[-1])
				puts "File was saved"
			rescue Exception => e
				e.message
			end
		elsif(/^open \w+\S$/ =~ input) #abrir archivo
			begin
				arr = input.split(/\s+/)
				@holder.load(arr[-1])
				puts "File was loaded"
			rescue Exception => e
				puts e.message
			end
		elsif(/^find [a-zA-Z0-9]+\s*$/ =~ input) #buscar
			arr = input.split(/\s+/)
			puts @holder.find(arr[1])
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
				if(arr[-1] != 'group')
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
	def start()
		while((input=gets.chomp)!='exit')
			input_check(input)
		end
	end
end

