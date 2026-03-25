{-# LANGUAGE EmptyDataDeriving #-}
-- cover all cases!
{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}
-- warn about incomplete patterns v2
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-}
-- write all your toplevel signatures!
{-# OPTIONS_GHC -fwarn-missing-signatures #-}
-- use different names!
{-# OPTIONS_GHC -fwarn-name-shadowing #-}
-- use all your pattern matches!
{-# OPTIONS_GHC -fwarn-unused-matches #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use map once" #-}
import Data.Char (ord, chr)
{-# HLINT ignore "Avoid lambda" #-}
{-# HLINT ignore "Eta reduce" #-}

-- Задача 1: Да се напише функция, която приема списък и връща неговия най-дълъг растящ подсписък
longestSublist :: [Int] -> [Int]
longestSublist l = helper l [] []
    where 
        helper :: [Int] -> [Int] -> [Int] -> [Int]
        helper [] _ m = m
        helper (x : xs) [] _ = helper xs [x] [x]
        helper (x : xs) c m = 
                if last c < x then 
                    helper xs new_curr (if length new_curr > length m then new_curr else m)
                else
                    helper xs [x] m
            where new_curr = c ++ [x]

-- Задача 2: Да се напише mergesort
mergesort :: [Int] -> [Int]
mergesort [] = []
mergesort [x] = [x]
mergesort l = merge (mergesort (take mid l)) (mergesort (drop mid l)) 
    where mid = length l `div` 2

merge :: [Int] -> [Int] -> [Int]
merge [] l = l 
merge l [] = l 
merge l1@(x : xs) l2@(y : ys) = if x > y then y : merge l1 ys else x : merge xs l2

-- За домашно:
-- Задача 3: Да се напише функция, която приема списък и число n, и връща нов списък от n-те най-големи числа в списъка. 
    -- Ако списъкът има по-малко от n елемента да връща грешка

-- ord, chr
-- Задача 4: Да се напише функция, която приема String и връща списък от наредени двойки като групира последователни символи в двойката (символ, брой срещания)
toTuple :: String -> [(Char, Int)]
toTuple [] = []
toTuple (x : xs) = (x, length l) : toTuple (dropWhile (==x) xs) 
    where l = takeWhile (==x) (x : xs)

-- Задача 5: Да се напише функция, която приема символ и число и връща нов символ по следните правила:
-- (символ, 1) -> същия символ с главна буква
-- (символ, n) -> същия символ с отместване n в ASCII таблицата
encode :: Char -> Int -> Char 
encode c 1 = chr $ ord 'A' + ord c - ord 'a'
encode c n = chr $ ord c + n

-- Задача 6: Да се напише функция, която приема стринг и символ x и връща същия стринг като между всеки два символа е поставен x
addDelim :: String -> Char -> String 
addDelim s d = take (length res - 1) res 
    where res = concatMap (:[d]) s

addDelimFromList :: String -> [Char] -> String 
addDelimFromList [] _ = [] 
addDelimFromList _ [] = error "Cannot have less delimiters than characters in the list"
addDelimFromList (x : xs) (y : ys) = x : y : addDelimFromList xs ys

-- Задача 7: Да се напише функция superWeakEncode, която приема стринг и връща нов стринг по следните правила:
    -- Замества всяка поредица от еднакви символи със символа, получен от задача 5.
    -- Между всеки едва символа поставя и броя числото, получено от задача 4 (освен когато броят е 1)
    -- Пример: aabbbdcccc -> c2e3Dg4

-- Тук приемаме, че няма редица по-дълга от 9
superWeakEncode :: String -> String 
superWeakEncode [] = []
superWeakEncode s = addDelimFromList (map (uncurry encode) tuples) (map head $ map show (map snd tuples))
    where 
        tuples = toTuple s

-- За да позволим редици по-дълги от 9:
addDelimFromList2 :: String -> [String] -> String 
addDelimFromList2 [] _ = [] 
addDelimFromList2 _ [] = error "greshka"
addDelimFromList2 (x : xs) (y : ys) = x : y ++ addDelimFromList2 xs ys

superWeakEncode2 :: String -> String 
superWeakEncode2 [] = []
superWeakEncode2 s = addDelimFromList2 (map (uncurry encode) tuples) (map show (map snd tuples))
    where 
        tuples = toTuple s

-- За домашно:
-- Задача 8: Да се напише обратната функция (superWeakDecode) 




