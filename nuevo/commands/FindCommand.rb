require_relative "Command.rb"

class FindCommand
	include Command
	def initialize(holder, params)
		@holder=holder
		@text=params.join(" ")
	end
	def execute()
		puts @holder.find(@text)
	end
end
