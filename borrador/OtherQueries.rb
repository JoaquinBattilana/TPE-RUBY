class OtherQueries
	AC=1
	COMPLETE = 2
	FIND = 3

	def initialize(holder, query)
		@holder = holder
		@text = query
		@process_id = parse
	end

	def execute
		case @process_id
		when AC
			@holder.ac
			puts "All completed task has been archived."
		when COMPLETE
			complete(@text)
		when FIND
			arr = @text.split(/\s+/)
			puts @holder.find(arr[1])
		end
	end

	def parse
		if(/^ac\s*$/ =~ @text) #archivar
			return AC
		elsif(/^complete [0-9]+\s*$/ =~ @text) #completar tarea
			return COMPLETE
		elsif(/^find [a-zA-Z0-9]+\s*$/ =~ @text) #buscar
			return FIND
		else
			show_error
		end
	end

	def complete(input)
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

	def show_error
		puts 'Invalid command. Use help for command list'
	end
end