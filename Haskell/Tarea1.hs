
lista = []

aDigitsRev :: Integer -> [Integer]
aDigitsRev 0 = []
aDigitsRev n
		| n < 1 = []
		| otherwise = lista ++ n `mod` 10 : aDigitsRev(n `div` 10)

aDigits :: Integer -> [Integer]
aDigits n = reverse (aDigitsRev n)

duplicarCadaDos :: [Integer] -> Bool -> [Integer]
duplicados = []
duplicarCadaDos [] _ = []
duplicarCadaDos (x:xs) g
			| g = duplicados ++ 2*x : duplicarCadaDos xs False
			| otherwise = duplicados ++ x : duplicarCadaDos xs True

suma :: [Integer] -> [Integer]
suma ls = map (\ x -> (x `div` 10) + (x `mod` 10)) ls

sumDigitos :: [Integer] -> Integer
sumDigitos ls = foldr (+) 0 (suma ls)

validar :: Integer -> [Char]
validar 0 = "Valido"
validar n
		| arg`mod`10 == 0 = "Valido"
		| arg`mod`10 /= 0 = "Invalido"
		| otherwise = error "Numero no valido"
		where arg = (sumDigitos(duplicarCadaDos (aDigits n) True))


