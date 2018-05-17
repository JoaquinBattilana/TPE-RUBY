require_relative "Command.rb"
require_relative "../exceptions/InvalidArguments.rb"

class FindCommand
	include Command
	def initialize(holder, params)
		raise InvalidArguments if params.empty?
		@holder=holder
		@text=params.join(" ")
	end
	def execute()
		puts @holder.find(@text)
	end
end
