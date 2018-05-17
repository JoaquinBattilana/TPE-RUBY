require_relative "commands/AddCommand.rb"
require_relative "commands/ListCommand.rb"
require_relative "commands/AcCommand.rb"
require_relative "commands/CompleteCommand.rb"
require_relative "commands/SaveCommand.rb"
require_relative "commands/OpenCommand.rb"
require_relative "commands/FindCommand.rb"
require_relative "commands/SetCommand.rb"
require_relative "commands/HelpCommand.rb"
require_relative "exceptions/NotSupportedCommand.rb"


class CommandManager
	COMMANDS_KEYWORDS={
		"add" => AddCommand,
		"list" => ListCommand,
		"ac" => AcCommand,
		"complete" => CompleteCommand,
		"save" => SaveCommand,
		"open" => OpenCommand,
		"find" => FindCommand,
		"set" => SetCommand,
		"help" => HelpCommand
	}
	def new_command(command,holder)
		return nil if (command.nil? || !(command.is_a?(String)))
		command_array = command.split(" ")
		keyword=command_array.first
		raise NotSupportedCommand unless COMMANDS_KEYWORDS.key?(keyword)
		parameters = command_array.drop(1)
		COMMANDS_KEYWORDS[keyword].new(holder, parameters)
	end
end

