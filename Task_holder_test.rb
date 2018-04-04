require_relative "Task_holder.rb"
require "date"

lista = Task_holder.new

puts "agrego tareas simples"
lista.add("hacer un test")
lista.add("Jugar al lol")
lista.add("Estudiar para parciales")

puts "agrego tareas con fecha"
pasado_mañana=Date.today + 1
lista.add("hacer que funcione","tomorow")
lista.add("Analisis",pasado_mañana+1)
lista.add("Quimica",pasado_mañana-4)

puts "agrego tareas con fecha y grupos"
lista.add("Salir",pasado_mañana,"+Fiesta")
lista.add("Practicar logica",pasado_mañana,"+POO")
lista.add("terminar practicas",pasado_mañana,"+POO")

puts "completo tareas"
lista.complete(1)
lista.complete(3)
lista.complete(21)

puts "listo tareas"
lista.list

puts "listo tareas por grupos"
lista.list_group

puts "listo tareas del grupo +poo"
lista.list_by_group("+POO")

puts "listo tareas para mas de una semana"
lista.list_due(pasado_mañana+7)

puts "listo tareas para hoy"
lista.list_due(Date.today)

puts "listo tareas vencidas"
lista.list_overdue

puts "seteo fecha hoy y grupo +quimica"
lista.set_date(Date.today)
lista.set_group("+quimica")

puts "agrego tareas"
lista.add("pilas")
lista.add("baterias")
lista.add("reacciones covalentes")

puts "las listo"
lista.list

puts "busco hac"
lista.find("hac")

puts "pruebo el ac"
lista.list
lista.ac
lista.list

puts "pruebo los saves"
lista.list
lista.save("lista1")
lista.load("lista1")
lista.list
