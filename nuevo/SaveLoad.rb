require "yaml"

class SaveLoad 
	@@PATH="/"
	def initialize
		throw "Cant instantiate this class"
	end
	def self.save(filename, keys, **args)
		file=File.new(@@PATH+file_name, "w+")
		hash = Hash.new()
		keys.each_with_index do |x,i|
		hash[x]=args[i]
		end
		file.syswrite(YAML.dump(hash))
		file.close()
	end
	
	def self.load(filename)
		file=File.read(filename)
		hash=YAML.load(file)
		throw CorruptedFile unless hash.instance_of?(Hash)
		hash
	end
	def self.set_path(path)
		@@PATH=path
	end
end

class CorruptedFile < Exception
	def message
		"Error: The file is corrupted"
	end
end
