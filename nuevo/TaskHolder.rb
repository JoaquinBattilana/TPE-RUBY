require "set"
require_relative "StringDate.rb"
require_relative "Task.rb"
require 'yaml' 

class TaskHolder
	
	def initialize 
		@set = SortedSet.new()
		@id=1
		@set_expiration_date=nil
		@set_group=nil
	end
	def add (description,expiration_date=nil,group=nil)
		expiration_date=@set_expiration_date if expiration_date == nil
		group=@set_group if group == nil
		new_task=Task.new(@id,description,expiration_date,group)
		puts new_task.group
		@set.add(new_task)
		@id +=1
		@id-1
	end
	def list
		@set.map {|task| task}
	end
	def complete(id)
		task=find_task_by_id(id)
		return false if task.complete?
		refresh_task(task)
		true
	end
	def complete?(id)
		task=find_task_by_id(id)
		task.complete?
	end
	def ac
		@set.each do |task|
			@set.delete(task) if task.complete?
		end
	end
	def list_due (up_to)
		yesterday=StringDate.new("yesterday")
		@set.find_all do |task|
		((task.expiration_date <=> (up_to + 1)) == -1) && ((task.expiration_date <=> yesterday) == 1)
		end
	end
	def list_overdue
		yesterday=StringDate.new("yesterday")
		@set.find_all do |task|
		task.expiration_date <= yesterday
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
		task.complete()
		@set.add(task)
	end

	def isEmpty?
		@set.empty?
	end
end
