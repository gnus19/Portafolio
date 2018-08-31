{-|
Description : Solucion al problema de la mochila (conseguir la lista de objetos con mayor valor con un peso maximo)
Copyright   : (c) USB, 2018
                  José Ignacio Palma
                  Andre Corcuera
Maintainer  : 13-11044@usb.ve, 12-10660@usb.ve

Programa construido en @Haskell@ recibe una lista de tuplas, especificando el objeto y su peso
y otra lista de tupla con su valor, un valor entero  que representa el peso maximo que se puede cargar en
la mochila y una lista de objetos que se deean colocar en la misma.

Retornando una lista de lista de objetos representados en Strings con el mayor valor posible y
con un peso menor o igual al maximo

[@Curso:@]

	Laboratorio de Lenguajes de Programación I

[@Trimestre:@]

	Enero Marzo 2018

[@Autores:@]

	* José Ignacio Palma (13-11044)

	* Andre Corcuera (12-10660)
-}

data Arbol a = Hoja a | Nodo a (Arbol a) (Arbol a) deriving (Show,Eq)

perteneceL2 :: Eq a => [a] -> [a] -> Bool
perteneceL2 (x:xs) y
    | not(elem x y) = False
    | (elem x y) && xs /= [] = perteneceL2 xs y
    | (elem x y) && xs == [] = True

contenidos::Eq a => Arbol a -> Arbol a -> Bool
contenidos a b = perteneceL2 (preorden a) (preorden b)
    where 
    	preorden (Hoja x)     = [x]
    	preorden (Nodo x i d) = x : (preorden i ++ preorden d)


 
import Data.List

data Peso p = Peso { listaP :: [([Char], Int)] } deriving (Eq, Show)
data Valor v = Valor { listaV :: [([Char], Int)] } deriving (Eq, Show)

-- | Primer elemento de la tupla
get1fst :: (a,b,c)	-- ^ Tupla
			-> a 	-- ^ Primer elemento de la tupla
get1fst (x,_,_) = x
-- | Segundo elemtento de la tupla
get2snd :: (a,b,c) -- ^ Tupla
			-> b	-- ^ Segundo elemento de la tupla
get2snd (_,x,_) = x
-- | Tercer elemento de la tupla
get3thd :: (a,b,c) 	-- ^ Tupla
			-> c 	-- ^ Tercer elemento de la tupla
get3thd (_,_,x) = x

-- | Particiones posibles del arreglo
particion :: [String] 	-- ^ Lista de strings a particionar
			-> [[String]] 	-- ^ Lista de todas las particiones posibles
particion [] = [[]]
particion (x:xs) = [x:ps | ps <- particion xs] ++ particion xs

-- | Auxiliar de maybe a int
aux :: Maybe Int 	-- ^ Tipo de dato maybe a sacar el valor entero
		-> Int 		-- ^ Valor entero
aux (Just a) = a
aux Nothing = 0

-- | Peso de un objeto
peso :: Peso p 		-- ^ Lista de tupla con primer elemento un string y de segundo el peso del objeto
		-> String 	-- ^ Objeto a buscar
		-> Int 		-- ^ Peso del objeto
peso (Peso ps) cad = aux (lookup cad ps)

-- | Peso total de la lista
pesoTotal :: Peso p 		-- ^ Lista de todos los objetos con su peso
			-> [String] 	-- ^ Lista de objeto a sumar el peso
			-> Int 			-- ^ Peso total de los objetos en la lista
pesoTotal (Peso ps) xs = sum (map (peso (Peso ps)) xs)

-- | Valor de un objeto
valor :: Valor v 		-- ^ Lista de todos los objetos con su valor
		-> String 		-- ^ Objeto a hallar valor
		-> Int 			-- ^ Valor del objeto
valor (Valor va) cad = aux (lookup cad va)

-- | Valor total de una lista
valorTotal :: Valor v 		-- ^ Lista de todos los objetos con su valor
			-> [String] 	-- ^ Lista de objetos a hallar valor total
			-> Int 			-- ^ Valor total de todos los objetos en la lista
valorTotal (Valor va) xs = sum (map (valor (Valor va)) xs)

-- | Retorna las combinaciones posibles para obtener el maximo valor sin pasarse del peso maximo
problemaMochila :: [String] 		-- ^ Lista de objetos que se quieren colocar
				-> Int 				-- ^ Peso maximo a cargar
				-> Peso p 			-- ^ Lista de todos los objetos con su peso
				-> Valor v 			-- ^ Lista de todos los objetos con su valor
				-> [[String]] 		-- ^ Lista de lista de objetos con mayor valor
problemaMochila xs pmax (Peso ps) (Valor va) = map (get1fst) (filter (\x -> get3thd x == maximo arregloV) arregloV)
			where arregloV = tripletasValidas pmax (zip3 (particion xs) (map (pesoTotal (Peso ps)) (particion xs)) (map (valorTotal (Valor va)) (particion xs)))

-- | Maximo valor
maximo :: [([String], Int, Int)] 	-- ^ Lista de tuplas con los objetos posibles a colocar
		-> Int 						-- ^ Valor maximo
maximo [] = 0
maximo xs = maximum (get3thd (unzip3 xs))

-- | Tripletas validas (peso total menor al permitido)
tripletasValidas :: Int -> [([String], Int, Int)] 	-- ^ Lista de tuplas de todas las listas de objetos
				-> [([String], Int, Int)] 			-- ^ Lista de tuplas con la lista de objetos que no pasan el peso maximo
tripletasValidas pmax xs = filter (\x -> get2snd x <= pmax) xs

