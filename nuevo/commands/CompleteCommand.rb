require_relative "Command.rb"

class CompleteCommand
	include Command
	def initialize(params)
		@id=params[1]
	end
	def execute(*objects)
		holder=objects[1]
		holder.complete(id)
	end
end