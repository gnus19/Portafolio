#!/usr/bin/env ruby
# encoding: utf-8
#
# Tarea 3 Laboratorio de Lenguajes de Programación
#
# Autores:
# 	Nombres:        Carnet:
# 	Andre Corcuera  12-10660
# 	Jose I. Palma   13-11044

# Ejercicio 1.1
# --------------------------------------
# Público: calcular el area del circulo.
#
# radio - Radio del circulo.
#
# Ejemplos
#
# circulo = Circulo.new(2)
# puts circulo.area
# => 12.566370614359172
#
# Devuelve el area del circulo.
class Circulo
	attr_reader :radio
  	attr_writer :radio

	def initialize(radio)
		if radio >= 0 
			@radio = radio
		else 
			abort "Error: radio invalido"
		end
	end

	def radio=(n_radio)
    	@radio = n_radio
  	end

  	def area
  		Math::PI*(@radio**2)
  	end
end

# Ejercicio 1.2
# --------------------------------------
# Público: calcular el volumen de un cilindro
#
# radio - Radio del cilindro.
# altura - Altura del cilindro.
#
# Ejemplos
#
# cilindro = Cilindro.new(2,3)
# puts cilindro.volumen
# => 56.548667764616276
#
# Devuelve el volumen del cilindro.
class Cilindro < Circulo
	attr_reader :altura
	attr_writer :altura

	def initialize(radio,altura)
		if radio >= 0 
			@radio = radio
		else 
			abort "Error: radio invalido"
		end

		if altura >= 0 
			@altura = altura
		else 
			abort "Error: altura invalida"
		end	
	end

	def altura=(n_altura)
    	@altura = n_altura
  	end

  	def volumen
  		@altura*Math::PI*(@radio**2)
  	end
end

# Ejercicio 2
# --------------------------------------
# Público: Operaciones con monedas
#
# Ejemplos
#
# 15.dolares.en(:euros)
# => 12.09(...) euros
#
# 100000.bolivares.comparar(2.dolares)
# => menor

# Modificamos las clases de los objetos
# "Integer" y "Float" para agregar metodos
# dolares, euros, yenes, bitcoins, bolivares
# que permitan crear nuevos objetos con
# la superclase "Moneda"
#
# Ejemplo
#
# (15.dolares) es un objeto Dolar de la superclase
# Moneda, por ende, recibe todos los metodos de 
# Dolar y Moneda a la vez.

#################### 2.a) ###################
class Integer
	def dolares
		return Dolar.new(self)
	end
	def euros
		return Euro.new(self)
	end
	def yenes
		return Yen.new(self)
	end
	def bolivares
		return Bolivar.new(self)
	end
	def bitcoins
		return Bitcoin.new(self)
	end
end

class Float
	def dolares
		return Dolar.new(self)
	end
	def euros
		return Euro.new(self)
	end
	def yenes
		return Yen.new(self)
	end
	def bolivares
		return Bolivar.new(self)
	end
	def bitcoins
		return Bitcoin.new(self)
	end
end
#############################################

################ CONSTANTES #################
# Si se quiere otro tipo de cambio, basta
# solo con cambiar las tasas de cambio de
# bolivar, euro, yen y bitcoins por dolar
BOLIVAR_X_DOLAR = 200000
EURO_X_DOLAR 	= 0.806042092
YEN_X_DOLAR		= 106.03869
BT_X_DOLAR		= 0.000103

# Calculo de inversos por dolar (dolar por Mnd):
DOLAR_X_BOLIVAR = 1.to_f/BOLIVAR_X_DOLAR.to_f
DOLAR_X_EURO 	= 1.to_f/EURO_X_DOLAR.to_f
DOLAR_X_YEN 	= 1.to_f/YEN_X_DOLAR.to_f
DOLAR_X_BT 		= 1.to_f/BT_X_DOLAR.to_f
#############################################

class Moneda
	attr_reader :valor,:tipo
	attr_writer :valor,:tipo

	def en(atm)
		puts (self.valor*self.cambio(atm)).to_s + " #{atm}"
	end

	def en_to_i(atm)
		self.valor*self.cambio(atm)
	end

	def comparar(mnd)
		if mnd.is_a?(Dolar) || mnd.is_a?(Euro) || mnd.is_a?(Yen) || mnd.is_a?(Bolivar) || mnd.is_a?(Bitcoin)
			if self.valor < mnd.en_to_i(self.tipo)
				puts :menor
			else
				puts :mayor
			end
		else 
			abort "Error en 'comparar': moneda no valida"
		end
	end
end

class Dolar < Moneda
	def initialize(d)
		@valor = d
		@tipo = :dolares
	end

	def cambio(moneda)
		if moneda == :euros
			EURO_X_DOLAR
		elsif moneda == :yens
			YEN_X_DOLAR
		elsif moneda == :bolivares
			BOLIVAR_X_DOLAR
		elsif moneda == :bitcoins
			BT_X_DOLAR
		else 
			abort "Error en 'cambio': cambio no encontrado"					
		end
	end
end

class Yen < Moneda
	def initialize(y)
		@valor = y
		@tipo = :yens
	end

	def cambio(moneda)
		if moneda == :dolares
			DOLAR_X_YEN
		elsif moneda == :euros
			DOLAR_X_YEN/DOLAR_X_EURO
		elsif moneda == :bolivares
			DOLAR_X_YEN/DOLAR_X_BOLIVAR
		elsif moneda == :bitcoins
			DOLAR_X_YEN/DOLAR_X_BT
		else 
			abort "Error en 'cambio': cambio no encontrado"			
		end
	end
end

class Euro < Moneda
	def initialize(e)
		@valor = e
		@tipo = :euros
	end

	def cambio(moneda)
		if moneda == :dolares
			DOLAR_X_EURO
		elsif moneda == :yens
			DOLAR_X_EURO/DOLAR_X_YEN
		elsif moneda == :bolivares
			DOLAR_X_EURO/DOLAR_X_BOLIVAR
		elsif moneda == :bitcoins
			DOLAR_X_EURO/DOLAR_X_BT
		else 
			abort "Error en 'cambio': cambio no encontrado"					
		end
	end
end

class Bolivar < Moneda
	def initialize(bs)
		@valor = bs
		@tipo = :bolivares
	end

	def cambio(moneda)
		if moneda == :euros
			DOLAR_X_BOLIVAR/DOLAR_X_EURO
		elsif moneda == :yens
			DOLAR_X_BOLIVAR/DOLAR_X_YEN
		elsif moneda == :dolares
			DOLAR_X_BOLIVAR
		elsif moneda == :bitcoins
			DOLAR_X_BOLIVAR/DOLAR_X_BT
		else 
			abort "Error en 'cambio': cambio no encontrado"		
		end
	end
end

class Bitcoin < Moneda
	def initialize(bc)
		@valor = bc
		@tipo = :bitcoins
	end

	def cambio(moneda)
		if moneda == :euros
			DOLAR_X_BT/DOLAR_X_EURO
		elsif moneda == :yens
			DOLAR_X_BT/DOLAR_X_YEN
		elsif moneda == :dolares
			DOLAR_X_BT
		elsif moneda == :bolivares
			DOLAR_X_BT/DOLAR_X_BOLIVAR
		else 
			abort "Error en 'cambio': cambio no encontrado"	
		end
	end
end

# Ejercicio 3
# --------------------------------------
class ProductoCartesiano
	def initialize(elem1, elem2)
		if !(elem1.respond_to? :each) || !(elem2.respond_to? :each)
			abort "Error en 'ProductoCartesiano': Uno o más parametros no son una colección"
		end
		if !elem1.empty?
			elem1.each do |x|
				if !elem2.empty?
					elem2.each do |y|
						puts ([]<<x<<y).inspect
					end
				else
					puts ([]<<x).inspect
				end
			end
		else
			if !elem2.empty?
				elem2.each do |y|
					puts ([]<<y).inspect
				end
			end
		end
	end
end

# Ejercicio 4
# --------------------------------------
module DFS

	def dfs(origen,visitados = [])
		if !visitados.include?(origen)
			visitados[visitados.count] = origen
		end

		(self[origen].to_list).each do |x|
			if !visitados.include?(x)
				visitados[visitados.count] = x
				dfs(x,visitados)
			end
		end

		return visitados
	end

  	def find(start, predicate)
  		path = dfs(start)
  		if path.include?(predicate)
  			puts predicate
  		else
  			puts nil.inspect
  		end
  	end

  	def path(start, predicate)
  		path = dfs(start)
  		if path.include?(predicate)
  			res_path = path.drop(path.index(predicate)+1)
  			puts (path - res_path).inspect
  		else
  			puts [].inspect
  		end
  	end
end

class Node
  	attr_reader :name

  	def initialize(name)
    	@name = name
    	@successors = []
  	end

  	def add_edge(successor)
    	@successors << successor
  	end

  	def to_s
    	"[#{@successors.map(&:name).join(', ')}]"
  	end

  	def to_list
  		@successors.map(&:name)
  	end
end

class Graph
	include DFS
	attr_reader :nodes

  	def initialize
    	@nodes = {}
  	end

  	def add_node(node)
    	@nodes[node.name] = node
  	end

  	def add_edge(predecessor_name, successor_name)
    	@nodes[predecessor_name].add_edge(@nodes[successor_name])
  	end

  	def [](name)
    	@nodes[name]
  	end

  	def origen
  		@nodes.each do |x|
  			return x[0]
  		end
  	end
end

################ EJEMPLOS #################
puts "\nEjemplo 1.1.a.b.c.d"
circulo = Circulo.new(2)
puts "b)"
circulo.radio = 3
puts "Radio:",circulo.radio
puts "d)"
puts "Area:",circulo.area

puts "\n----------------------------\n\n"

puts "Ejemplo 1.2.a.b.c.d"
cilindro = Cilindro.new(2,3)
puts "b)"
cilindro.altura = 2
cilindro.radio = 3
puts "Radio:",cilindro.radio
puts "Altura:",cilindro.altura
puts "d)"
puts "volumen:",cilindro.volumen

puts "\n----------------------------\n\n"

puts "Ejemplo 2\n\n"
puts "b)"
15.dolares.en(:euros)
puts "c)"
100000.bolivares.comparar(2.dolares)


puts "\n----------------------------\n\n"

puts "Ejemplo 3"
ProductoCartesiano.new([:a],[1,2,3])

puts "\n----------------------------\n\n"

puts "Ejemplo 4"
graph = Graph.new
graph.add_node(Node.new(1))
graph.add_node(Node.new(2))
graph.add_node(Node.new(3))
graph.add_node(Node.new(4))
graph.add_node(Node.new(5))
graph.add_edge(1, 2)
graph.add_edge(1, 3)
graph.add_edge(1, 5)
graph.add_edge(2, 4)
graph.add_edge(2, 5)

puts "Grafo:"
puts graph.nodes.to_s
puts "\n"
puts "find(1, 9/3):"
graph.find(1,9/3)
puts "path(1, 9/3):"
graph.path(1,9/3)
###########################################
