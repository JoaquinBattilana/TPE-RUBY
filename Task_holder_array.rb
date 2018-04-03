require "set"
require "date"
require_relative "Task_array.rb"

class Task_holder
	attr_reader :array
	def initialize 
		@array = Array.new()
		@id=1
		@set_date=nil
		@set_group=nil
	end
	def add (description,expiration_date=@set_date,group=@set_group)
		new_task=Task.new(@id,description,expiration_date,group)
		@array<<new_task
		puts "Todo [#{@id}: #{description}] added."
		@id +=1
		self
	end

	def complete (id)
		if id<=@id then 
			@array.each do |task|
				if task.id == id then
					task.completed 
					puts "Todo [#{task.id}: #{task.description}] completed."
				end
			end
		else puts "invalid task"
		end
		self
	end
	def ac
		@array.each do 
			@array.each {|task| @array.delete(task) if task.complete==1}
		end
	end
	def list
		@array.sort!
		puts "All"
		@array.each {|task| puts task.to_s}
	end
	def list_due (up_to)
	@array.sort!
	yesterday=(Date.today - 1)
	puts "all"
		@array.each do |task|
		puts task.to_s if (((task.expiration_date <=> (up_to + 1)) == -1) && ((task.expiration_date <=> yesterday) == 1))
		end
	end
	def list_overdue
		@array.sort!
		@array.each do |task|
		puts task.to_s if ((task.expiration_date <=> (Date.today - 1)) == -1)
		end
	end
	def list_by_group (group)
		@array.sort!
		puts "#{group}"
		@array.each do |task|
		puts task.to_s_without_group if task.group == group
		end
	end
	def list_group
		@array.sort!
		group = Array.new()
		group<<""
		@array.each do |task|
			unless group.include? task.group then
			list_by_group (task.group)
			group<< task.group
			end
		end
	end
	def savefile
	
	end
	def openfile
	
	end
	def set_date (date)
		@set_date=date
	end
	def set_group (group)
		@set_group=group
	end
	def find (text)
		@array.each do |task|
		puts task.to_s if task.description.include? text
		end
	end
end

