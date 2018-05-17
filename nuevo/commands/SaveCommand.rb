require_relative "Command.rb"
require_relative "../SaveLoad.rb"
class SaveCommand
	include Command
	def initialize(holder, params)
		raise NotSupportedCommand if params.empty?
		@holder=holder
		@filename=params.join(" ")
	end

	def execute()
		SaveLoad.save(@filename,@holder)
		puts "File was saved succesfully"
	end
end
