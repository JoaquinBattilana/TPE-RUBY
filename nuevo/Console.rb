require_relative "CommandManager.rb"
require_relative "TaskHolder.rb"

class Console

	def initialize()
		@holder = TaskHolder.new
		@manager = CommandManager.new
	end

	def start()
		while((input=gets.chomp)!='exit')
			begin
				command = @manager.new_command(input, @holder)
				command.execute()
			rescue Exception => e
				puts e.message
			end
		end
	end
end
