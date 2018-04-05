require "set"
require "date"
require_relative "Task.rb"
require 'yaml' 

class Task_holder
	
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
		@set.find_all do |task|
		(task.expiration_date <=> (Date.today - 1)) == -1
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
end
