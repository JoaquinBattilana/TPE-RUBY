require_relative "Command.rb"

class CompleteCommand
	include Command
	def initialize(params)
		@id=params[0]
	end
	def execute(*objects)
		holder=objects[0]
<<<<<<< Updated upstream
=======
		puts @id
>>>>>>> Stashed changes
		holder.complete(@id)
	end
end
