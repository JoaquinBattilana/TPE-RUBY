require "yaml"
require_relative "../exceptions/CorruptedFile.rb"

class SaveLoad 
	@@PATH="./"
	def initialize
		throw "Cant instantiate this class"
	end
	def self.save(filename, object)
		file=File.new(@@PATH+filename, "w+")
		file.syswrite(YAML.dump(object))
		file.close()
	end
	
	def self.load(filename,type)
		file=File.read(filename)
		object=YAML.load(file)
		raise CorruptedFile unless object.is_a?(type)
		object
	end
	def self.set_path(path)
		@@PATH=path
	end
end
