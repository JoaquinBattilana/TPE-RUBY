if arg[-1] == "today"
date=Date.today 
elsif if arg[-1] == "tomorrow"
date=(Date.today+1)
else
fechas=arg[-1].split("/")
date = Date.new(fecha[-1],fehca[-2],fecha[-3])
else