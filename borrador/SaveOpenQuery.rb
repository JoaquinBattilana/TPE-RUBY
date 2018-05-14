class SaveOpenQuery
	SAVE = 1
	OPEN = 2

	def initialize(holder, query)
		@holder = holder
		@text = query
		@process_id = parse
	end

	def execute
		case @process_id
		when SAVE
			save(@text)
		when OPEN
			open_file(@text)
		end
	end

	def parse
		if(/^save \w+\S$/ =~ @text) #guardar archivo
			return SAVE
		elsif(/^open \w+\S$/ =~ @text) #abrir archivo
			return OPEN
		else
			show_error
		end
	end

	def save(input)
		begin
			arr = input.split(/\s+/)
			@holder.save(arr[-1])
			puts "File was saved"
		rescue Exception => e
			e.message
		end
	end

	def open_file(input)
		if(!(@holder.isEmpty?))
			puts "Are you sure you want to overwrite? Y/N"
			conf = gets.chomp
			if(conf == "Y")
				load(input)
			else
				puts "Command not executed"
			end
		else
			load(input)
		end
	end

	def load(text)
		begin
			arr = text.split(/\s+/)
			@holder.load(arr[-1])
			puts "File was loaded"
		rescue Exception => e
			puts e.message
		end
	end

	def show_error
		puts 'Invalid command. Use help for command list'
	end
end