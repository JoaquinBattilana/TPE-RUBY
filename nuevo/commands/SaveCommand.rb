require_relative "Command.rb"
require_relative "../exceptions/InvalidArguments.rb"
class SaveCommand
	include Command
	def initialize(holder, params)
		raise InvalidArguments if params.empty?
		@holder=holder
		@filename=params.join(" ")
	end

	def execute()
		SaveLoad.save(@filename,@holder)
		puts "File was saved succesfully"
	end
end
