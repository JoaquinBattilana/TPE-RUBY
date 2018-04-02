#include Input
class Input
	def initialize
		@arg=nil
	end

	def to_s
		'Error'
	end

	#def generate_desc(arg)
	#	arg.delete(arg[0])
	#	arg.delete(arg[0])
	#	arg.delete(arg[-1])
	#	arg.delete(arg[-1])
	#	return arg[0] + ' ' + arg[1]
	#end

	def input_check(holder,input)
		if (/^add [a-zA-Z]+|\+/ =~ input)
			if (/^add \+[a-zA-Z]+ ([a-zA-Z]+|\s)+$/ =~ input)
				#@arg = input.split(/\s+/)
				#holder.add(@arg[1],nil,self.generate_desc(@arg))
			elsif(/^add ([a-zA-Z]+|\s)+$/ =~ input)
				#@arg = input.split(/\s+/)
				#holder.add(nil,nil,self.generate_desc(@arg))
			elsif (/^add ([a-zA-Z]+|\s)+ due (tomorrow|today|[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9])$/ =~ input)
				#@arg = input.split(/\s+/)
				#holder.add(nil, @arg[-1],self.generate_desc(@arg))
			elsif(/^add \+[a-zA-Z]+ ([a-zA-Z]+|\s)+ due (tomorrow|today|[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9])$/ =~ input)
				#@arg = input.split(/\s+/)
				#holder.add(@arg[1],@arg[-1], self.generate_desc(@arg)
			else
				'Comando no valido'
			end
		elsif (/^list/ =~ input)
			if (/^list due (yesterday|today|tomorrow|this-week)/ =~ input)
				#@arg = input.split(/\s+/)
				#holder.list_due(@arg[2])
			elsif(/^list group/ =~ input)
				#holder.list_group
			elsif (/^list overdue/ =~ input)
				#holder.list_overdue
			elsif (/^list\s*$/ =~ input)
				#holder.list
			else
				'Comando no valido'
			end		
		elsif(/^ac\s*$/ =~ input)
			'se archiva'
		elsif(/^complete [0-9]+\s*$/ =~ input)
			#@arg = input.split(/\s+/)
			#holder.complete(@arg[1])
		elsif(/^save [a-zA-Z]+\s*$/ =~ input)
			#@arg = input.split(/\s+/)
			#holder.savefile(@arg[1])
		elsif (/^open [a-zA-Z]+\s*$/ =~ input)
			#@arg = input.split(/\s+/)
			#holder.openfile(@arg[1])
		else	
			'Comando no valido'
		end
	end
end

#command_line = Input.new
#input = gets.chomp
#while (input !~ /^exit\s*$/) do
#	puts command_line.input_check(holder,input)
#	input = gets.chomp
#end 
