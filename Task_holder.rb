require "set"
require "date"
require_relative "Task.rb"
require 'yaml' 

class TaskHolder
	
	def initialize 
		@set = SortedSet.new()
		@id=1
		@set_date=nil
		@set_group=nil
	end
	def add (description,expiration_date=@set_date,group=@set_group)
		expiration_date=@set_date if expiration_date == nil
		group = @set_group if group == nil
		new_task=Task.new(@id,description,expiration_date,group)
		@set.add(new_task)
		@id +=1
		@id-1
	end
	def list
		@set.map {|task| task}
	end
	def complete (task)
		return false if task.complete == 1
		refresh_task(task)
		true
	end
	def ac
		@set.each do |task|
			@set.delete(task) if task.complete==1
		end
	end
	def list_due (up_to)
		yesterday=(Date.today - 1)
		@set.find_all do |task|
		((task.expiration_date <=> (up_to + 1)) == -1) && ((task.expiration_date <=> yesterday) == 1)
		end
	end
	def list_overdue
		yesterday=(Date.today - 1)
		@set.find_all do |task|
		(task.expiration_date <=> yesterday) == -1
		end
	end
	def list_by_group (group)
		@set.find_all{|task| task.group==group}
	end
	def list_group
		group = [" "]
		@set.each {|task| group << task.group unless group.include? task.group}
		group
	end
	def save(file_name)
		a=File.new(file_name, "w+")
		a.syswrite(YAML.dump(@set))
		a.close()
	end
	def load(file_name)
		a=File.read(file_name)
		@set=YAML.load(a)
		@id=1
		@set.each {|task| @id=task.id if @id<task.id}
		@id+=1
	end
	def set_date (date)
		@set_date=date
	end
	def set_group (group)
		@set_group=group
	end
	
	def find (text)
		@set.find_all do |task|
		task.description.upcase.include? text.upcase
		end
	end
	def find_task_by_id(id)
		@set.find{|task| task.id==id}
	end
	private def refresh_task(task)
		@set.delete(task)
		task.completed()
		@set.add(task)
	end

	def isEmpty?
		@set.empty?
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
end
