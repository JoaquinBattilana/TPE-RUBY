require_relative "Task_holder.rb"
require "date"

lista = Task_holder.new

lista.add("hacer un test")
lista.add("Jugar al lol")
lista.add("Estudiar para parciales")

pasado_mañana=Date.today + 1
lista.add("hacer que funcione","tomorow")
lista.add("Analisis",pasado_mañana+1)
lista.add("Quimica",pasado_mañana-4)


lista.add("Salir",pasado_mañana,"+Fiesta")
lista.add("Practicar logica",pasado_mañana,"+POO")
lista.add("terminar practicas",pasado_mañana,"+POO")


lista.complete(1)
lista.complete(3)
lista.complete(21)


lista.list
lista.list_group
lista.list_by_group("+POO")
lista.list_due(pasado_mañana+7)
lista.list_due(Date.today)
lista.list_overdue


lista.set_date(Date.today)
lista.set_group("+quimica")

lista.add("pilas")
lista.add("baterias")
lista.add("reacciones covalentes")