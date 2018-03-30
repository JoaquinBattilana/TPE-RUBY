require "set"
require "Date"

class Task
	include Comparable

	attr_reader :id, :description, :complete, :expiration_date
	def initialize(id,description,expiration_date=nil)
		@description=description
		@id=id
		@complete=0  #usamos un integer en vez de un boolean porque integer tiene implementado el metodo <=> (spaceship) y boolean no.
		if(expiration_date=="tomorrow")
			@expiration_date=Date.today+1
		elsif(expiration_date=="today")
			@expiration_date==Date.today
		else
			@expiration_date=expiration_date
		end
	end
	
	def completed()
		@complete=1
	end
	def to_s
		"#{@id}["+(@complete==1? "x":" ")+"] %10s #{@description}" % [@expiration_date]
	end

	def ==(other)
		return false unless other.is_a?(Task)
		@id==other.id
	end
	def <=>(other)
		return nil unless other.is_a?(Task)
		c=@complete<=>other.complete 
		if(c==0)
			c=@id<=>other.id
		end
		c
	end
end

set = SortedSet.new()
task4=Task.new(4,"bsd")
task3=Task.new(3,"asd", "tomorrow")
task1=Task.new(1,"Hacer La Tarea")
task2=Task.new(2,"No hacer la tarea")
task3.completed()
set.add(task1)
set.add(task2)
set.add(task3)
set.add(task4)
set.each do |x|
puts x
end


