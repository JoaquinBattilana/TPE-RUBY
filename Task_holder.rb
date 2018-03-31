require "set"
require "date"

class task_holder
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
	end
	def list
		puts "All"
		@set.each do {|task| tasl.to_s}
		end
	end
	def complete (id)
		if id<=@id then @set.each do |task|
			if task.id == id then
				task.complete 
				puts "Todo [#{task.id}: #{task.description}] completed."
			end
		else puts "invalid task"
		end
	end
	def ac
		@set.each {|task| task=nil if task.complete?}
	end
	def list_due (up_to)
	puts "all"
		@set.each do |task|
		puts "task.to_s" if ((task.date <=> (up_to + 1) == -1) && (task.date <=> (date.today - 1) == 1))
		end
	end
	def list_overdue
		@set.each do |task|
		puts "task.to_s" if (task.date <=> (date.today - 1) == -1)
		end
	end
	def list_group (group)
		puts "#{group}"
		@set.each do |task|
		puts "task.to_s" if task.group == group
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