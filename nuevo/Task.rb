require "set"
require_relative "StringDate.rb"

class Task
	include Comparable

	attr_reader :id, :description, :expiration_date, :group, :complete
	def initialize(id,description,expiration_date=nil,group=nil)
		@description=description
		@id=id
		@complete=0  #usamos un integer en vez de un boolean porque integer tiene implementado el metodo <=> (spaceship) y boolean no.
		@expiration_date=expiration_date
		@group=group
	end
	
	def completed
		@complete=1
	end
	def complete?
		@complete == 1
	end
	def to_s
		"%3s["%(@id) + (self.complete?() ? "x" : " ") + "] %10s "%(@expiration_date) + (@group.nil? ? "" : "+#{@group} ") + "#{@description}"
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
		"%3s["%(@id)+(self.complete?() ? "x":" ")+"]  %10s  #{@description}" %(@expiration_date)
	end
	def hash()
		[@id].hash
	end
	def eql?(other)
		return nil unless other.is_a(Task)
		@id==other.id
	end
end
