require_relative "Command.rb"

class AcCommand
	include Command
	def initialize(holder, params)
		raise NotSupportedCommand unless params.empty?
		@holder = holder
	end

	def execute()
		@holder.ac
		puts "All completed task has been archived."
	end
end
