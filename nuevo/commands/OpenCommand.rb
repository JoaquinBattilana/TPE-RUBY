require_relative "Command.rb"
require_relative "../SaveLoad.rb"

class OpenCommand
	include Command
	def initialize(params)
		@params=params.join(" ")
	end
	def execute(*objects)
		holder=objects[0]
		SaveLoad.load(@params)
	end
end
