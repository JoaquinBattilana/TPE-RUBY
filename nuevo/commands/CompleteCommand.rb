require_relative "Command.rb"

class CompleteCommand
	include Command
	def initialize(params)
		raise NotSupportedCommand if (params.size!=1 )
		@id=params[0].to_i
	end
	def execute(*objects)
		holder=objects[0]
		task = holder.find_task_by_id(@id)
		if task==nil
			puts "Invalid Task"
		elsif holder.complete(task)
			puts "Todo [#{@id}: #{task.description}] completed."
		else
			puts "Task #{@id} already completed"
		end
	end
end
