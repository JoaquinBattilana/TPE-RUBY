require "set"
require "date"

class Task
	include Comparable

	attr_reader :id, :description, :complete, :expiration_date, :group
	def initialize(id,description,expiration_date=nil,group="")
		@description=description
		@id=id
		@complete=0  #usamos un integer en vez de un boolean porque integer tiene implementado el metodo <=> (spaceship) y boolean no.
		@expiration_date=expiration_date
		@group=group
	end
	
	def completed
		@complete=1
	end
	def to_s
		"%3s["%(@id)+(@complete==1? "x":" ")+"]  %10s  #{@group} #{@description}" %(date_to_str)
	end
	def ==(other)
		return false unless other.is_a?(Task)
		@id==other.id
	end
	def <=>(other)
		return nil unless other.is_a?(Task)
		c=@complete<=>other.complete
		if(c==0) then
			if(@expiration_date==nil && other.expiration_date!=nil) then
				c=-1
			elsif(other.expiration_date==nil && @expiration_date!=nil) then
				c=1
			else
				c=@id<=>other.id
			end
		end
		c
	end
	def to_s_without_group
		"%3s["%(@id)+(@complete==1? "x":" ")+"]  %10s  #{@description}" %(date_to_str)
	end
	private def date_to_str()
		str=@expiration_date.to_s
		if(@expiration_date==Date.today)
			str="today"
		elsif(@expiration_date==Date.today-1)
			str="yesterday"
		elsif(@expiration_date==Date.today+1)
			str="tomorrow"
		end
		str
	end
	def hash()
		[@id].hash
	end
	def eql?(other)
		return nil unless other.is_a(Task)
		@id==other.id
	end
end
