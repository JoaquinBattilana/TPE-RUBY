require_relative "Command.rb"
require_relative "../SaveLoad.rb"
class SaveCommand
	include Command
	def initialize(params)
		raise NotSupportedCommand if params.empty?
		@filename=params.join(" ")
	end

	def execute(*objects)
		holder=objects[0]
		new_holder=SaveLoad.save(@filename,holder)
	end
end