class Task
	attr_reader :number, :group, :date
	def initialize(description,number,date,group)
		@description=description
		@number=number
		@date=date
		@group=group
		@complete=0
	end

	def to_s
		"#{@number}\t[" {@complete? "X":" "} "]\t" {@date.nil? " ":"#{@date}\t"} {@group.nil? " ":"#{group}\t"} "#{@description}"
	end
end

task = Task.new("ASASD",1,"tomorrow","+POO")
puts task