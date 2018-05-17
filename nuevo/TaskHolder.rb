require "set"
require_relative "StringDate.rb"
require_relative "Task.rb"
require 'yaml' 

class TaskHolder
	attr_reader :set, :id, :set_expiration_date, :set_group

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
	def ac
		@set.each do |task|
			@set.delete(task) if task.complete?
		end
	end
	def list_due (string)
		@set.find_all do |task|
		if(task.expiration_date !=  nil)
			task.expiration_date.is_in?(string)
		end
		end
	end
	def list_overdue
		@set.find_all do |task|
			task.expirated?
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
		@set_expiration_date=date
	end
	def set_group (group)
		@set_group=group
	end

	def complete(task)
		return false if task.complete?
		refresh_task(task)
		true
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

	def set_state(holder)
		@set=holder.set()
		@id=holder.id
		@set_expiration_date=nil
		@set_group=nil
	end

	def isEmpty?
		@set.empty?
	end
end
