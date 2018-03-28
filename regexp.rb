class RegExp
	def initialize
		@arg=nil
	end

	def to_s
		"Esto se usa para probar que onda"
	end

	def lets_see(arg)
		if (arg =~ /add(.*)/)
			'Aca se agrega una tarea'
		elsif (arg =~ /list/)
			'Aca la estamos listando'
		else
			'Comando no valido'
		end
	end
end

#ahora esta todo hardcodeado, pero la idea es que vean
#como seria y despues implementamos el gets, etc.
line1 = 'add tarea'
line2 = 'list'
line3 = 'afsdgarwtg'

check=RegExp.new				#OUTPUT
puts check.lets_see(line1) # Aca se agrega una tarea
puts check.lets_see(line2) # Aca la estamos listando
puts check.lets_see(line3) # Comando no valido
