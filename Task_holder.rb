require "set"
require "date"

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
		@set.each {|task| task.to_s}
		end
	def complete (id)
		if id<=@id then 
			@set.each do |task|
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
		@set.each {|task| task=nil if task.complete?}
	end
	def list_due (up_to)
	puts "all"
		@set.each do |task|
		puts "task.to_s" if (((task.date <=> (up_to + 1)) == -1) && ((task.date <=> (date.today - 1)) == 1))
		end
	end
	def list_overdue
		@set.each do |task|
		puts "task.to_s" if ((task.date <=> (date.today - 1)) == -1)
		end
	end
	def list_by_group (group)
		puts "#{group}"
		@set.each do |task|
		puts "task.to_s_without_group" if task.group == group
		end
	end
	def list_group
		group = Array.new()
		@set.each do |task|
			unless group.include? task.group then
			list_by_group (task.group)
			group.add (task.group)
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
		@set.each do |task|
		puts task.to_s if task.include? text
		end
	end
end

