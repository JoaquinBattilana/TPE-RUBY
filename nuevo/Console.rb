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
				command = @manager.new_command(input)
				command.execute(@holder)
			rescue Exception => e
				puts e.message
			end
		end
	end
end

console=Console.new()
console.start()