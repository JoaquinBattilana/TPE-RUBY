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
		new_task=Task.new(@id,description,expiration_date,group)
		@set.add(new_task)
		puts "Todo [#{@id}: #{description}] added."
		@id +=1
		self
	end
	def list
		puts "All"
		@set.each {|task| puts task.to_s}
		end
	def complete (id)
		if id<=@id then 
			@set.map! do |task|
				if task.id == id then
					task.completed 
					puts "Todo [#{task.id}: #{task.description}] completed."
				end
			task
			end
		else puts "invalid task"
		end
		self
	end
	def ac
		@set.each do
			@set.each {|task| @set.delete(task) if task.complete==1}
		end
	end
	def list_due (up_to)
	yesterday=(Date.today - 1)
	puts "all"
		@set.each do |task|
		puts task.to_s if (((task.expiration_date <=> (up_to + 1)) == -1) && ((task.expiration_date <=> yesterday) == 1))
		end
	end
	def list_overdue
		@set.each do |task|
		puts task.to_s if ((task.expiration_date <=> (Date.today - 1)) == -1)
		end
	end
	def list_by_group (group)
		puts "#{group}"
		@set.each do |task|
		puts task.to_s_without_group if task.group == group
		end
	end
	def list_group
		group = Array.new()
		group<<" "
		@set.each do |task|
			unless group.include? task.group then
			list_by_group (task.group)
			group<< task.group
			end
		end
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
		@set.each do |task|
		puts task.to_s if task.description.include? text
		end
	end
end

