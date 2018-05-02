input = gets.chomp
while (input !~ /^exit\s*$/) do
	if(/^add ([a-zA-Z0-9]+|\s)+$/ =~ input)
		if(%r"^add ([a-zA-Z]+|\s)+ due (tomorrow|today)$" =~ input)
			puts "#{input} es valido"
		elsif(/add hola#{"/"}/.match(input))
			puts "#{input} tambien es valido"
		else
			puts "no valido"
		end
	end
		input = gets.chomp
	end 
puts "Gracias vuelva pronto"

#input = gets.chomp
#while (input !~ /^exit\s*$/) do
#	if(/^list \+[a-zA-Z]+\s*$/ =~ input)
#		puts "#{input} es valido"
#		else
#			puts "no valido"
#		end
#		input = gets.chomp
#	end 
