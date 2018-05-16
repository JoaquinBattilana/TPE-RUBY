require_relative "Command.rb"
require_relative "../SaveLoad"

class OpenCommand
	include Command
	def initialize(params)
		@params=params.join" "
	end
	def execute(*objects)
		holder=objects[1]
		SaveLoad.load(@params)
	end
end
