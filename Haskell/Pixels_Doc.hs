{-|
Module      : Pixels
Description : Carácter(es) a Pixel
Copyright   : (c) USB, 2018
                  José Ignacio Palma
                  Andre Corcuera
Maintainer  : 13-11044@usb.ve, 12-10660@usb.ve

Programa construido en @Haskell@ que recibe una especificación básica de la forma en
la que el texto debería estar representado en el led display y además su color, el resultado
es mostrado por pantalla en un String.

Para generalizar, Pixel en Haskell será representado por un [String]

[@Curso:@]

	Laboratorio de Lenguajes de Programación I

[@Trimestre:@]

	Enero Marzo 2018

[@Autores:@]

	* José Ignacio Palma (13-11044)

	* Andre Corcuera (12-10660)
-}

module Pixels
(	
	decToBin
	, agregarCeros
	, cambiarAst
	, font 
	, pixelsToString
	, pixelListToPixels
	, pixelListToString
	, concatPixels
	, messageToPixels
	, espacios
	, up
	, down
	, left
	, right
	, upsideDown
	, backwards
	, negative
) where

import Data.Char
import Data.List

-- | fontBitmap contiene un mapa de bits apropiado, contiene los posibles caracteres imprimibles.

fontBitmap =
  [
    [ 0x00, 0x00, 0x00, 0x00, 0x00 ], --  (space)
    [ 0x00, 0x00, 0x5F, 0x00, 0x00 ], --  !
    [ 0x00, 0x07, 0x00, 0x07, 0x00 ], --  "
    [ 0x14, 0x7F, 0x14, 0x7F, 0x14 ], --  #
    [ 0x24, 0x2A, 0x7F, 0x2A, 0x12 ], --  $
    [ 0x23, 0x13, 0x08, 0x64, 0x62 ], --  %
    [ 0x36, 0x49, 0x55, 0x22, 0x50 ], --  &
    [ 0x00, 0x05, 0x03, 0x00, 0x00 ], --  '
    [ 0x00, 0x1C, 0x22, 0x41, 0x00 ], --  (
    [ 0x00, 0x41, 0x22, 0x1C, 0x00 ], --  )
    [ 0x08, 0x2A, 0x1C, 0x2A, 0x08 ], --  *
    [ 0x08, 0x08, 0x3E, 0x08, 0x08 ], --  +
    [ 0x00, 0x50, 0x30, 0x00, 0x00 ], --  ,
    [ 0x08, 0x08, 0x08, 0x08, 0x08 ], --  -
    [ 0x00, 0x60, 0x60, 0x00, 0x00 ], --  .
    [ 0x20, 0x10, 0x08, 0x04, 0x02 ], --  /
    [ 0x3E, 0x51, 0x49, 0x45, 0x3E ], --  0
    [ 0x00, 0x42, 0x7F, 0x40, 0x00 ], --  1
    [ 0x42, 0x61, 0x51, 0x49, 0x46 ], --  2
    [ 0x21, 0x41, 0x45, 0x4B, 0x31 ], --  3
    [ 0x18, 0x14, 0x12, 0x7F, 0x10 ], --  4
    [ 0x27, 0x45, 0x45, 0x45, 0x39 ], --  5
    [ 0x3C, 0x4A, 0x49, 0x49, 0x30 ], --  6
    [ 0x01, 0x71, 0x09, 0x05, 0x03 ], --  7
    [ 0x36, 0x49, 0x49, 0x49, 0x36 ], --  8
    [ 0x06, 0x49, 0x49, 0x29, 0x1E ], --  9
    [ 0x00, 0x36, 0x36, 0x00, 0x00 ], --  :
    [ 0x00, 0x56, 0x36, 0x00, 0x00 ], --  ;
    [ 0x00, 0x08, 0x14, 0x22, 0x41 ], --  <
    [ 0x14, 0x14, 0x14, 0x14, 0x14 ], --  =
    [ 0x41, 0x22, 0x14, 0x08, 0x00 ], --  >
    [ 0x02, 0x01, 0x51, 0x09, 0x06 ], --  ?
    [ 0x32, 0x49, 0x79, 0x41, 0x3E ], --  @
    [ 0x7E, 0x11, 0x11, 0x11, 0x7E ], --  A
    [ 0x7F, 0x49, 0x49, 0x49, 0x36 ], --  B
    [ 0x3E, 0x41, 0x41, 0x41, 0x22 ], --  C
    [ 0x7F, 0x41, 0x41, 0x22, 0x1C ], --  D
    [ 0x7F, 0x49, 0x49, 0x49, 0x41 ], --  E
    [ 0x7F, 0x09, 0x09, 0x01, 0x01 ], --  F
    [ 0x3E, 0x41, 0x41, 0x51, 0x32 ], --  G
    [ 0x7F, 0x08, 0x08, 0x08, 0x7F ], --  H
    [ 0x00, 0x41, 0x7F, 0x41, 0x00 ], --  I
    [ 0x20, 0x40, 0x41, 0x3F, 0x01 ], --  J
    [ 0x7F, 0x08, 0x14, 0x22, 0x41 ], --  K
    [ 0x7F, 0x40, 0x40, 0x40, 0x40 ], --  L
    [ 0x7F, 0x02, 0x04, 0x02, 0x7F ], --  M
    [ 0x7F, 0x04, 0x08, 0x10, 0x7F ], --  N
    [ 0x3E, 0x41, 0x41, 0x41, 0x3E ], --  O
    [ 0x7F, 0x09, 0x09, 0x09, 0x06 ], --  P
    [ 0x3E, 0x41, 0x51, 0x21, 0x5E ], --  Q
    [ 0x7F, 0x09, 0x19, 0x29, 0x46 ], --  R
    [ 0x46, 0x49, 0x49, 0x49, 0x31 ], --  S
    [ 0x01, 0x01, 0x7F, 0x01, 0x01 ], --  T
    [ 0x3F, 0x40, 0x40, 0x40, 0x3F ], --  U
    [ 0x1F, 0x20, 0x40, 0x20, 0x1F ], --  V
    [ 0x7F, 0x20, 0x18, 0x20, 0x7F ], --  W
    [ 0x63, 0x14, 0x08, 0x14, 0x63 ], --  X
    [ 0x03, 0x04, 0x78, 0x04, 0x03 ], --  Y
    [ 0x61, 0x51, 0x49, 0x45, 0x43 ], --  Z
    [ 0x00, 0x00, 0x7F, 0x41, 0x41 ], --  [
    [ 0x02, 0x04, 0x08, 0x10, 0x20 ], --  \
    [ 0x41, 0x41, 0x7F, 0x00, 0x00 ], --  ]
    [ 0x04, 0x02, 0x01, 0x02, 0x04 ], --  ^
    [ 0x40, 0x40, 0x40, 0x40, 0x40 ], --  _
    [ 0x00, 0x01, 0x02, 0x04, 0x00 ], --  `
    [ 0x20, 0x54, 0x54, 0x54, 0x78 ], --  a
    [ 0x7F, 0x48, 0x44, 0x44, 0x38 ], --  b
    [ 0x38, 0x44, 0x44, 0x44, 0x20 ], --  c
    [ 0x38, 0x44, 0x44, 0x48, 0x7F ], --  d
    [ 0x38, 0x54, 0x54, 0x54, 0x18 ], --  e
    [ 0x08, 0x7E, 0x09, 0x01, 0x02 ], --  f
    [ 0x08, 0x14, 0x54, 0x54, 0x3C ], --  g
    [ 0x7F, 0x08, 0x04, 0x04, 0x78 ], --  h
    [ 0x00, 0x44, 0x7D, 0x40, 0x00 ], --  i
    [ 0x20, 0x40, 0x44, 0x3D, 0x00 ], --  j
    [ 0x00, 0x7F, 0x10, 0x28, 0x44 ], --  k
    [ 0x00, 0x41, 0x7F, 0x40, 0x00 ], --  l
    [ 0x7C, 0x04, 0x18, 0x04, 0x78 ], --  m
    [ 0x7C, 0x08, 0x04, 0x04, 0x78 ], --  n
    [ 0x38, 0x44, 0x44, 0x44, 0x38 ], --  o
    [ 0x7C, 0x14, 0x14, 0x14, 0x08 ], --  p
    [ 0x08, 0x14, 0x14, 0x18, 0x7C ], --  q
    [ 0x7C, 0x08, 0x04, 0x04, 0x08 ], --  r
    [ 0x48, 0x54, 0x54, 0x54, 0x20 ], --  s
    [ 0x04, 0x3F, 0x44, 0x40, 0x20 ], --  t
    [ 0x3C, 0x40, 0x40, 0x20, 0x7C ], --  u
    [ 0x1C, 0x20, 0x40, 0x20, 0x1C ], --  v
    [ 0x3C, 0x40, 0x30, 0x40, 0x3C ], --  w
    [ 0x44, 0x28, 0x10, 0x28, 0x44 ], --  x
    [ 0x0C, 0x50, 0x50, 0x50, 0x3C ], --  y
    [ 0x44, 0x64, 0x54, 0x4C, 0x44 ], --  z
    [ 0x00, 0x08, 0x36, 0x41, 0x00 ], --  {
    [ 0x00, 0x00, 0x7F, 0x00, 0x00 ], --  |
    [ 0x00, 0x41, 0x36, 0x08, 0x00 ]  --  }
  ]

-- | Convierte un número decimal en binario.
decToBin :: Int 	-- ^ Número (entero) decimal.
		-> [Int]	-- ^ Lista (enteros) que representa el número decimal en binario.
decToBin 0 = [0]
decToBin num
		| num == 0 = []
		| modulo == 0 = 0 : decToBin (num `div` 2)
		| modulo == 1 = 1 : decToBin (num `div` 2)
		| otherwise = error "Error"
		where modulo = num `mod` 2

-- | Sí la representación binaria (lista) no posee tamaño 8, esta función rellena la lista con 0 (a la derecha).
-- Devuelve "error", sí la lista proporcionada es de tamaño mayor a 8.
--
-- Por ejemplo:
--
-- >>> agregarCeros [0,1,0]
-- [0,1,0,0,0,0,0,0]
--
-- >>> agregarCeros [0,1,0,0,0,0,0,0,0]
-- *** Exception: Error
agregarCeros :: [Int]	-- ^ Representación binaria (lista).
			-> [Int]	-- ^ Representación binaria (lista) de tamaño 8.
agregarCeros [] = []
agregarCeros arr
		| (length arr) == 8 = arr ++ []
		| (length arr) < 8 = agregarCeros (arr ++ [0])
		| otherwise = error "Error"

-- | Crea una cadena de texto que representa con un '*' el bit encendido.
cambiarAst :: [Int]		-- ^ Número binaria a crear cadena de texto o Pixel.
			-> String 	-- ^ Cadena de texto que representa el número binario introducido.
cambiarAst [] = []
cambiarAst (a:arr)
		| a == 1 = '*' : cambiarAst arr
		| a == 0 = ' ' : cambiarAst arr
		| otherwise = error "Error"

-- | Crea una lista de espacios y asteriscos, que representan los pixeles 
-- que simulan al carácter proporcionado.
--
-- Por ejemplo:
--
-- >>> font 'A'
-- [" *** ","*   *","*   *","*   *","*****","*   *","*   *"]
--
-- Para obtener el carácter en forma de Pixels usamos @mapM_ print@:
--
-- >>> mapM_ print(font 'A')
-- " *** "
-- "*   *"
-- "*   *"
-- "*   *"
-- "*****"
-- "*   *"
-- "*   *"
font :: Char		-- ^ Carácter a convertir en pixels.
	-> [String]		-- ^ Lista de String que representan los pixels encendidos y apagados para cada linea del carácter.
font valor = map cambiarAst (transpose (map (init . agregarCeros) (map decToBin (fontBitmap !! ((ord valor) - 32)))))

-- | Convierte un pixels en una cadena de texto.
pixelsToString :: [String]		-- ^ Pixels a convertir en cadena de texto.
				-> String 		-- ^ Cadena de texto (string) que representa los pixels proporcionada.
pixelsToString valor = concat valor

-- | Convierte una lista de pixels en un pixels.
pixelListToPixels :: [[String]]	-- ^ Lista de pixels a convertir en pixels.
				-> [String]		-- ^ Lista de (string) pixels que representa la lista de pixels proporcionada.
pixelListToPixels valores = foldl1 (\x y -> x ++ [""] ++ y) valores

-- | Convierte una lista de pixels en una cadena de texto.
pixelListToString :: [[String]] -- ^ Lista de pixels a convertir en pixels.
				-> String 		-- ^ Cadena de texto (string) que representa la lista de pixels proporcionada.
pixelListToString valores = pixelsToString (pixelListToPixels valores)

-- | Concatena una lista de pixels.
concatPixels :: [[String]] 		-- ^ Lista de pixels a concatenar en pixels.
			-> [String]			-- ^ Pixels concatenados.
concatPixels valores = foldl1 (\x y -> zipWith (++) x y) valores

-- | Convierte una cadena de texto en pixels.
messageToPixels :: String 		-- ^ Cadena de texto a convertir en pixels.
				-> [String]		-- ^ Pixels que representan la cadena de texto proporcionada.
messageToPixels cadena = foldl1 (\x y -> (zipWith3 (\x y z -> x++y++z) x [" ", " ", " ", " ", " ", " ", " "] y)) (map font cadena)

-- | Crear una cadena de texto vacía del mismo tamaño que la cadena proporcionada.
espacios :: String 		-- ^ Cadena de texto (entrada).
		-> String 		-- ^ Cadena de texto vacía del mismo tamaño de la cadena entrada.
espacios "" = ""
espacios (v1:v)
		| (length v) == 0 = " "
		| (length v) /= 0 = " " ++ espacios v

-- | [@Efecto especial: @] Corre 1 posición hacía arriba el carácter pixeleado que se proporcione.
--
-- Por ejemplo:
--
-- >>> mapM_ print(up(font 'B'))
-- "*   *"
-- "*   *"
-- "**** "
-- "*   *"
-- "*   *"
-- "**** "
-- "**** "
up :: [String] 			-- ^ Pixels al que se le aplicará el efecto "UP".
	-> [String]			-- ^ Pixels con el efecto "UP" aplicado.
up valor = (tail valor) ++ [head valor]

-- | [@Efecto especial: @] Corre 1 posición hacía abajo el carácter pixeleado que se proporcione.
--
-- Por ejemplo:
--
-- >>> mapM_ print(down(font 'B'))
-- "**** "
-- "**** "
-- "*   *"
-- "*   *"
-- "**** "
-- "*   *"
-- "*   *"
down :: [String] 		-- ^ Pixels al que se le aplicará el efecto "DOWN".
	-> [String]			-- ^ Pixels con el efecto "DOWN" aplicado.
down valor =  (last valor):init valor

-- | [@Efecto especial: @] Corre 1 posición a la izquierda el carácter pixeleado que se proporcione.
--
-- Por ejemplo:
--
-- >>> mapM_ print(left(font 'A'))
-- "***  "
-- "   **"
-- "   **"
-- "   **"
-- "*****"
-- "   **"
-- "   **"
left :: [String] 		-- ^ Pixels al que se le aplicará el efecto "LEFT".
	-> [String] 		-- ^ Pixels con el efecto "LEFT" aplicado.
left valor = transpose (tail pixel ++ [head pixel])
		where pixel = transpose valor

-- | [@Efecto especial: @] Corre 1 posición a la derecha el carácter pixeleado que se proporcione.
--
-- Por ejemplo:
--
-- >>> mapM_ print(right(font 'A'))
-- "  ***"
-- "**   "
-- "**   "
-- "**   "
-- "*****"
-- "**   "
-- "**   "
right :: [String] 		-- ^ Pixels al que se le aplicará el efecto "RIGHT".
	-> [String]			-- ^ Pixels con el efecto "RIGHT" aplicado.
right valor = transpose (last pixel:init pixel)
		where pixel = transpose valor

-- | Dado un pixels, esta función devuelve su inverso o voltea verticalmente el pixels.
-- Sí el pixels proporcionado es simétrico verticalmente, no se notará ningún cambio.
-- Por ejemplo:
--
-- >>> mapM_ print(upsideDown(font 'C'))
-- " *** "
-- "*   *"
-- "*    "
-- "*    "
-- "*    "
-- "*   *"
-- " *** "
--
-- >>> mapM_ print(upsideDown(font 'P'))
-- "*    "
-- "*    "
-- "*    "
-- "**** "
-- "*   *"
-- "*   *"
-- "**** "
upsideDown :: [String]	-- ^ Pixels al que se le aplicará el efecto "upsideDown".
		 -> [String]	-- ^ Pixels con el efecto "upsideDown" aplicado.
upsideDown valor = reverse valor

-- | Dado un pixels, esta función devuelve su opuesto o voltea horizontalmente el pixels.
-- Sí el pixels proporcionado es simétrico horizontalmente, no se notará ningún cambio.
--
-- Por ejemplo:
--
-- >>> mapM_ print(backwards(font 'A'))
-- " *** "
-- "*   *"
-- "*   *"
-- "*   *"
-- "*****"
-- "*   *"
-- "*   *"
--
-- >>> mapM_ print(backwards(font '/'))
-- "     "
-- "*    "
-- " *   "
-- "  *  "
-- "   * "
-- "    *"
-- "     "
--
-- Observe que 'A' es un pixel simétrico, mientras que '/' no lo es.
backwards :: [String] 	-- ^ Pixels al que se le aplicaará el efecto "BACKWARDS".
		-> [String]		-- ^ Pixels con el efecto "BACKWARDS" aplicado.
backwards valor = transpose (reverse pixel)
		where pixel = transpose valor

-- | Dado un pixels, esta función devuelve su representación negativa.
--
-- Por ejemplo:
--
-- >>> mapM_ print(negative(font 'A'))
-- "*   *"
-- " *** "
-- " *** "
-- " *** "
-- "     "
-- " *** "
-- " *** "
negative :: [String] 	-- ^ Pixels al que se le aplicará el efecto "NEGATIVE"
		-> [String]		-- ^ Pixels con el efecto "NEGATIVE" aplicado.
negative valor = map (map (\x -> if x == '*' then ' ' else '*')) valor