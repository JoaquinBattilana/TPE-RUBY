require_relative "Task_holder.rb"
require_relative "AddQuery.rb"
require_relative "ListQuery.rb"
require_relative "SaveOpenQuery.rb"
require_relative "OtherQueries.rb"
require_relative "SetQuery.rb"
require "date"
class Input
	FULL_ADD = 1
	ADD_DATE_DESC = 2
	ADD_GROUP_DESC = 3
	ADD_DESC = 4

	def initialize
		@holder = TaskHolder.new
	end

	def to_s
		'Error'
	end

	def show_error
		puts 'Invalid command. Use help for command list'
	end

	def input_check(input)
		if (/^add/ =~ input) #add con grupo y desc
			add = AddQuery.new(@holder, input)
			add.execute
		elsif (/^list/ =~ input)
			list = ListQuery.new(@holder, input)
			list.execute
		elsif(/^ac\s*$/ =~ input) #archivar
			ac = OtherQueries.new(@holder, input)
			ac.execute
		elsif(/^complete [0-9]+\s*$/ =~ input) #completar tarea
			complete = OtherQueries.new(@holder, input)
			complete.execute
		elsif(/^save \w+\S$/ =~ input) #guardar archivo
			save = SaveOpenQuery.new(@holder, input)
			save.execute
		elsif(/^open \w+\S$/ =~ input) #abrir archivo
			open = SaveOpenQuery.new(@holder, input)
			open.execute
		elsif(/^find [a-zA-Z0-9]+\s*$/ =~ input) #buscar
			find = OtherQueries.new(@holder, input)
			find.execute
		elsif(/^set/ =~ input) 
			set = SetQuery.new(@holder,input)
			set.execute
		elsif(/^help\s*$/ =~ input)
			help
		else
			show_error
		end
	end

	def help()
		puts "add - Adds another task; options include:\n\t[GROUP_NAME] - Name of the group where the task will be; Format: +[GROUP_NAME]\n\t[DESCRIPTION] - A text that describes the task\n\tdue [DATE] - Date where the task is due; Format: DD/MM/YYYY

list - List all tasks; if no parameters ar given, lists all tasks with/without groups and with/without date; options include:\n\t[GROUP_NAME] - List a specific group; Format: +[GROUP_NAME]\n\tdue [DATE] - Lists all due tasks; Format: today | tomorrow | this-week\n\tgroup - Lists all tasks with its group\n\toverdue - Lists all overdue tasks

ac - Archives all completed tasks

complete - complete a task; options include:\n\t[DESCRIPTION] - Description of the task to complete

save - saves all tasks in a file; options include:\n\t[FILE_NAME] - Name of the file to save

open - opens a file with tasks; options include:\n\t[FILE_NAME] - Name of the file to open

find - finds a task that contains the text received; options include:\n\t[TEXT] - Text to find on the tasks

set - sets a default date or group; if no parameters are given, removes default date/group; options include:\n\tdate_task [DATE] - Default date to add; Format: DD/MM/YYYY\n\tgroup [GROUP_NAME] - Default group to add; Format: +[GROUP_NAME]"
	end

	def start()
		while((input=gets.chomp)!='exit')
			input_check(input)
		end
	end
end
