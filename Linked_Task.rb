class Node
	
	def initialize ()
		@next_node=nil
		@task=nil
	end
	def add (description,number,date,group)
		do
		@next_node=Node.new()
		@next_node.task=Task.new(description,number,date,group)
		puts "Todo [#{self.task.number}: #{self.task.description}] added."
		if @task.nil?
		else
		@next_node.add(description,number,date,group)
	end
	def list 
		do
		self.task.to_s
		next_node.list unless next_node.nil?
	end
	def complete (number)
		task.complete if (self.task.number==number)
		else do 
		@next_node.complete(number-1) unless next_node.nil?
	end
	def date 
		self.task.date
	end
	def group
		self.task.group
	end
end
