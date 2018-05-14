class ListQuery
	LIST_GROUP = 1
	LIST_BY_DATE = 2
	LIST_ALL_GROUPS = 3
	LIST_OVERDUE = 4
	LIST_ALL = 5
	def initialize(holder, query)
		@holder = holder
		@text = query
		@list_id = parse
	end

	def execute
		case @list_id
		when LIST_GROUP
			arr = @text.split(/\s+/)
			puts "#{arr[-1]}"
			(@holder.list_by_group(arr[-1])).each {|task| puts task.to_s_without_group}
		when LIST_BY_DATE
			puts "All"
			arr = @text.split(/\s+/)
			puts @holder.list_due(to_date(arr[-1]))
		when LIST_ALL_GROUPS
			a=@holder.list_group
			a.each do |group|
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

	def parse
		if(/^list \+[a-zA-Z]+$/ =~ @text) #list specific group
			return LIST_GROUP
		elsif (/^list due (today|tomorrow|this-week)\s*$/ =~ @text) #lsit con fecha
			return LIST_BY_DATE
		elsif(/^list group\s*$/ =~ @text) #list all groups
			return LIST_ALL_GROUPS
		elsif(/^list overdue\s*$/ =~ @text) #list overdue
			return LIST_OVERDUE
		elsif(/^list\s*$/ =~ @text) #list all
			return LIST_ALL
		else
			show_error
		end	
	end

	def show_error
		puts 'Invalid command. Use help for command list'
	end
end