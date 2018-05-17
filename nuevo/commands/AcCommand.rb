require_relative "Command.rb"
require_relative "../exceptions/InvalidArguments.rb"

class AcCommand
	include Command
	def initialize(holder, params)
		raise InvalidArguments unless params.empty?
		@holder = holder
	end

	def execute()
		@holder.ac
		puts "All completed task has been archived."
	end
end
