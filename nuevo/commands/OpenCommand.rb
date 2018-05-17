require_relative "Command.rb"
require_relative "../utilities/SaveLoad.rb"

class OpenCommand
	include Command
	def initialize(holder, params)

		@holder=holder
		@filename=params.join(" ")
	end
	def execute()
		new_holder=SaveLoad.load(@filename, TaskHolder)
		puts "Are you sure to override? Enter yes for confirmation."
		confirmation=gets.chomp
		if confirmation=="yes"
			@holder.set_state(new_holder)
			puts "File was opened succesfully"
		end
	end
end
