require_relative "Command.rb"

class HelpCommand
	HELP_TEXT="add - Adds another task; options include:\n\t[GROUP_NAME] - Name of the group where the task will be; Format: +[GROUP_NAME]\n\t[DESCRIPTION] - A text that describes the task\n\tdue [DATE] - Date where the task is due; Format: DD/MM/YYYY

	list - List all tasks; if no parameters ar given, lists all tasks with/without groups and with/without date; options include:\n\t[GROUP_NAME] - List a specific group; Format: +[GROUP_NAME]\n\tdue [DATE] - Lists all due tasks; Format: today | tomorrow | this-week\n\tgroup - Lists all tasks with its group\n\toverdue - Lists all overdue tasks

	ac - Archives all completed tasks

	complete - complete a task; options include:\n\t[DESCRIPTION] - Description of the task to complete

	save - saves all tasks in a file; options include:\n\t[FILE_NAME] - Name of the file to save

	open - opens a file with tasks; options include:\n\t[FILE_NAME] - Name of the file to open

	find - finds a task that contains the text received; options include:\n\t[TEXT] - Text to find on the tasks

	set - sets a default date or group; if no parameters are given, removes default date/group; options include:\n\tdate_task [DATE] - Default date to add; Format: DD/MM/YYYY\n\tgroup [GROUP_NAME] - Default group to add; Format: +[GROUP_NAME]"
	include Command
	def initialize(params)
		throw NotSupportedCommand unless params.empty? 
	end
	def execute(*objects)
		puts HELP_TEXT
	end
end