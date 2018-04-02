class RegExp
	def initialize
		@arg=nil
	end

	def to_s
		"Esto se usa para probar que onda"
	end

	def lets_see(arg)
		if (/^add [a-zA-Z]+|\+/ =~ arg)
			'entra aca'
			if (/^add \+[a-zA-Z]+ ([a-zA-Z]+|\s)+$/ =~ arg)
				'tarea con grupo'
			elsif(/^add [a-zA-Z]+$/ =~ arg)
				'tarea normal'
			elsif (/^add ([a-zA-Z]+|\s)+ due (tomorrow|today|[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9])$/ =~ arg)
				'tarea con fecha'
			elsif(/^add \+[a-zA-Z]+ ([a-zA-Z]+|\s)+ due (tomorrow|today|[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9])$/ =~ arg)
				'tarea con grupo y fecha'
			else
				'Comando no valido'
			end
		elsif (/^list/ =~ arg)
			if (/^list due (yesterday|today|tomorrow)/ =~ arg)
				'lista con fecha'
			elsif(/^list group/ =~ arg)
				'lista por grupo'
			elsif (/^list overdue/ =~ arg)
				'lista vencidas'
			elsif (/^list\s*$/ =~ arg)
				'lista forma simple'
			else
				'Comando no valido'
			end		
		elsif(/^ac\s*$/ =~ arg)
			'se archiva'
		elsif(/^complete [0-9]+\s*$/ =~ arg)
			'se completa'
		elsif(/^save [a-zA-Z]+\s*$/ =~ arg)
			'se guarda'
		elsif (/^open [a-zA-Z]+\s*$/ =~ arg)
			'se abre'
		elsif (/^exit\s*$/ =~ arg)
			'se sale del programa'
		else	
			'Comando no valido'
		end
	end
end


#------------------AREA DE TESTING/IMPLEMENTACION--------------------


#ahora esta todo hardcodeado, pero la idea es que vean
#como seria y despues implementamos el gets, etc.
line1 = 'add tarea'
line2 = 'add otra tarea due tomorrow'
line3 = 'add +poo terminar tp'
line4 = 'list'
line5 = 'list due tomorrow'
line6 = 'complete 1'
line7 = 'complete 12sdfasgasg'
line8 = 'save filename'
line9 = 'exit'

check=RegExp.new				
puts check.lets_see(line1) 
puts check.lets_see(line2) 
puts check.lets_see(line3) 
puts check.lets_see(line4) 
puts check.lets_see(line5) 
puts check.lets_see(line6) 
puts check.lets_see(line7) 
puts check.lets_see(line8) 
puts check.lets_see(line9)