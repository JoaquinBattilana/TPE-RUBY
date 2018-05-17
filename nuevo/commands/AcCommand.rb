require_relative "Command.rb"

class AcCommand
	include Command
	def initialize(params)
		raise NotSupportedCommand unless params.empty?
	end

	def execute(*objects)
		holder = objects[0]
		holder.ac
		puts "All completed task has been archived."
	end
end
