require_relative "Command.rb"
require_relative "../StringDate.rb"

class AddCommand
	include Command
	def initialize(holder, params)
		@holder=holder
		text=params.join(" ")
		@group=nil
		@date=nil
		@description=""
		if(/^\+[a-zA-Z]+ ([a-zA-Z0-9]+|\s)+ due .+$/ =~ text) #add group desc y date
			@group = (params[0])
			@date = StringDate.new(params[-1])
			@description = params[1...-2].join(" ")
		elsif (/^([a-zA-Z0-9]+|\s)+ due .+$/ =~ text) #add desc y date
			@description = params[0...-2].join(" ")
			@date = StringDate.new(params[-1])
		elsif (/^\+[a-zA-Z]+ ([a-zA-Z0-9]+|\s)+$/ =~ text) #add group and desc
			@group = (params[0])
			@description= params[1..-1].join(" ")
		elsif(/^([a-zA-Z0-9]+|\s)+$/ =~ text) #add desc
			@description=params.join(" ")
		else
			raise NotSupportedCommand
		end
	end
	def execute()
		id = @holder.add(@description,@date,@group)
		puts "Todo [#{id}:#{@description}] added."
	end
end
