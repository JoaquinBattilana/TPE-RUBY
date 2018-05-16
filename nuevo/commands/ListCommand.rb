require_relative "Command.rb"
require_relative "../StringDate.rb"

class ListCommand
	include Command
	LIST_GROUP = 1
	LIST_BY_DATE = 2
	LIST_ALL_GROUPS = 3
	LIST_OVERDUE = 4
	LIST_ALL = 5
	def initialize(parameters)
		text=parameters.join(" ")
		@date=nil
		@text=nil
		@group=nil
		if(/^\+[a-zA-Z]+$/ =~ text) #list specific group
			@command = LIST_GROUP
			@group=text[1..-1]
		elsif (/^due .*$/ =~ text) #lsit con fecha
			@date = parameters[1..-1].join(" ")
			@command = LIST_BY_DATE
		elsif(/^group\s*$/ =~ text) #list all groups
			@command = LIST_ALL_GROUPS
		elsif(/^overdue\s*$/ =~ text) #list overdue
			@command = LIST_OVERDUE
		elsif(parameters.empty?) #list all
			@command =LIST_ALL
		else
			raise NotSupportedCommand
		end	
	end

	def execute(*objects)
		holder=objects[0]
		case @command
		when LIST_GROUP
			puts "#{@group}"
			holder.list_by_group(@group).each {|task| puts task.to_s_without_group}
		when LIST_BY_DATE
			puts "All"
			arr = @text.split(/\s+/)
			puts holder.list_due(to_date(arr[-1]))
		when LIST_ALL_GROUPS
			a=@holder.list_group
			a.each do |group|
			puts group
			(holder.list_by_group(group)).each {|task| puts task.to_s_without_group}
			end
		when LIST_OVERDUE
			puts "All"
			puts holder.list_overdue
		when LIST_ALL
			puts "All"
			puts holder.list
		end
	end

end