require_relative "Command.rb"
require_relative "../SaveLoad"
class SaveCommand
	include Command
	def initialize(params)
		@params=params.join(" ") 
	end

	def execute(*objects)
		holder=objects[0]
		Saveload.save(@params,1,holder)
	end
end