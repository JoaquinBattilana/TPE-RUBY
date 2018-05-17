require_relative "Command.rb"
require_relative "../SaveLoad.rb"

class OpenCommand
	include Command
	def initialize(params)
		@filename=params.join(" ")
	end
	def execute(*objects)
		holder=objects[0]
		new_holder=SaveLoad.load(@filename, TaskHolder)
		puts "Are you sure to override? Enter yes for confirmation."
		confirmation=gets.chomp
		if confirmation=="yes"
			holder.set_state(new_holder)
		end
	end
end
