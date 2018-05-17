require_relative "Command.rb"
require_relative "../utilities/StringDate.rb"
require "date"
require_relative "../exceptions/InvalidArguments.rb"

class ListCommand
	include Command
	LIST_GROUP = 1
	LIST_WEEK=2
	LIST_BY_DATE = 3
	LIST_ALL_GROUPS = 4
	LIST_OVERDUE = 5
	LIST_ALL = 6
	def initialize(holder, parameters)
		@holder=holder
		text=parameters.join(" ")
		@date=nil
		@group=nil
		if(/^\+[a-zA-Z]+$/ =~ text) #list specific group
			@command = LIST_GROUP
			@group=text[1..-1]
		elsif (/^due this-week$/ =~ text) #lsit con fecha
			@date = parameters[1]
			@command = LIST_WEEK
		elsif((/^due .*$/ =~ text))
			@date = StringDate.new(parameters[1..-1].join(" "))
			@command = LIST_BY_DATE
		elsif(/^group\s*$/ =~ text) #list all groups
			@command = LIST_ALL_GROUPS
		elsif(/^overdue\s*$/ =~ text) #list overdue
			@command = LIST_OVERDUE
		elsif(parameters.empty?) #list all
			@command =LIST_ALL
		else
			raise InvalidArguments
		end	
	end

	def execute()
		case @command
		when LIST_GROUP
			puts "#{@group}"
			@holder.list_by_group(@group).each {|task| puts task.to_s_without_group}
		when LIST_BY_DATE
			puts "All"
			puts @date
			puts @holder.list_due(@date)
		when LIST_WEEK
			puts "All"
			puts @holder.list_due(@date)
		when LIST_ALL_GROUPS
			aux=@holder.list_group
			aux.each do |group|
			puts group
			(@holder.list_by_group(group)).each {|task| puts task.to_s_without_group}
			end
		when LIST_OVERDUE
			puts "All"
			puts @holder.list_overdue
		when LIST_ALL
			puts "All"
			puts @holder.list
		end
	end

end
