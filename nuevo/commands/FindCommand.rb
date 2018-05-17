require_relative "Command.rb"

class FindCommand
	include Command
	def initialize(params)
		@text=params.join(" ")
	end
	def execute(*objects)
		holder=objects[0]
		holder.find(@text)
	end
end