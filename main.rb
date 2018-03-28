 class ConsoleTask
 	@@key_words=["add", "list", "complete", "ac",
 	 "save", "open"]
 	def initiliaze
 		@user_input=""
 		@task_list=Node.new()
 	end
 	def user_input
 		@user_input=gets.split
 	end
 	private def validate_user_input
 		key_words.include?(@user_input)
 	end
 end


consola = ConsoleTask.new()
while(user_input!="exit")
