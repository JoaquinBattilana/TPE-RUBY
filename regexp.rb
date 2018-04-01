class RegExp
	def initialize
		@arg=nil
	end

	def to_s
		"Esto se usa para probar que onda"
	end

	def lets_see(arg)
		if (/add [a-zA-Z]+|\+/ =~ arg)
			'entra aca'
			if (/add \+[a-zA-Z]+ [a-zA-Z]+$/ =~ arg)
				'tarea con grupo'
			elsif(/add [a-zA-Z]+$/ =~ arg)
				'tarea normal'
			elsif (/add [a-zA-Z]+ due (tomorrow|today|[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9]))$/ =~ arg)
				'tarea con fecha'
			elsif(/add \+[a-zA-Z]+ [a-zA-Z]+ due (tomorrow|today|[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9]))$/ =~ arg)
				'tarea con grupo y fecha'
			else
				'Comando no valido'
			end
		elsif (arg =~ /list [a-zA-Z]+/)
			'Aca la estamos listando'
		else
			'Comando no valido'
		end
	end
end

#ahora esta todo hardcodeado, pero la idea es que vean
#como seria y despues implementamos el gets, etc.
line1 = 'add'
line2 = 'add asdasd'
line3 = 'add asdfasdf due tomor'
line4 = 'add +asdasd asfda due tomorrow'
line5 = 'add '
line6 = 'add +asd asdaf'
line7 = 'add due tomorro'
line8 = 'add +asdasd asfda due '

check=RegExp.new				#OUTPUT
puts check.lets_see(line1) # 
puts check.lets_see(line2) # 
puts check.lets_see(line3) # 
puts check.lets_see(line4) # 
puts check.lets_see(line5) # 
puts check.lets_see(line6) # 
puts check.lets_see(line7) # 
puts check.lets_see(line8) # 


#add ([a-zA-Z]+)|((\+[a-zA-Z]+) [a-zA-Z]+)|([a-zA-Z]+ due (tomorrow|today|[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9]))|((\+[a-zA-Z]+) [a-zA-Z]+ due (tomorrow|today|[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9]))