class RegExp
	def initialize
		@arg=nil
	end

	def to_s
		"Esto se usa para probar que onda"
	end

	def lets_see(arg)		
		if (/^add [a-zA-Z]+|\+/ =~ arg)
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
		else	
			'Comando no valido'
		end
	end
end


check=RegExp.new
input = gets.chomp
while (input !~ /^exit\s*$/) do
	puts check.lets_see(input)
	input = gets.chomp
end