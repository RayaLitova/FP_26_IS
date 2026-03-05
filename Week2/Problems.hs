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
{-# HLINT ignore "Use max" #-}
import GHC.Read (list)
{-# HLINT ignore "Use foldr" #-}
{-# HLINT ignore "Redundant if" #-}


-- Още един пример за pattern matching

isOneOrTwo :: Int -> Bool
isOneOrTwo 1 = True
isOneOrTwo 2 = True
isOneOrTwo _ = False

--- Още малко рекурсия

-- Задача 1: Да се напише функция, която при подадени 2 числа n и m връща n на m-та степен
pow :: Int -> Int -> Int
pow _ 0 = 1
pow n m = n * pow n (m-1)

-- Задача 2: Да се напише функция, която намира сумата на цифрите на подадено число
sumDigits :: Int -> Int
sumDigits 0 = 0
sumDigits n = digit + sumDigits (div n 10)
    where
        digit = rem n 10

-- Списъци

-- Основни функции:
    -- Списък - [1,2,3,4]
    -- Дължина - length [1,2,3] -> 3 
    -- Добавяне на елементи в началото - 4 : [1,2,3] -> [4,1,2,3]
    -- Конкатенация - [1,2] ++ [3,4] -> [1,2,3,4]
    -- Добавяне на елемент в края - [1,2,3] ++ [4] -> [1,2,3,4]

-- Задача 1: Да се дефинира списък с числата от 1 до 5
list15 :: [Int]
list15 = [1,2,3,4,5]

-- Задача 2: Да се напише функция, която генерира списък с числата от 1 до n (n е аргумент на функцията)
-- Опция 1: С рекурсия
generateList :: Int -> [Int]
generateList 0 = []
generateList n = generateList (n-1) ++ [n]

-- Опция 2: С генератор
generateList2 :: Int -> [Int]
generateList2 n = [1..n]

-- Задача 3: Да се напише функция, която по подаден списък от числа намира сумата на елементите му
sumList :: [Int] -> Int
sumList [] = 0
sumList (x : xs) = x + sumList xs
-- Вградена функция: sum 

-- Задача 4: Да се напише функция, която по подаден списък и число n връща елемента на n-та позиция в списъка
getElem :: [Int] -> Int -> Int
getElem [] _ = -1
getElem (x : _) 0 = x
getElem (_ : xs) n = getElem xs (n-1)
-- Вградена функция: elem

-- Задача 4.5: Да се напише функция, която по подаден елемент връща неговия индекс (Ако има повторения, връща индекса на първото срещане)
getIndex :: [Int] -> Int -> Int
getIndex [] _ = -1
getIndex (x : xs) n
  | x == n = 0
  | res == -1 = -1
  | otherwise = 1 + res
  where
      res = getIndex xs n

-- Задача 5: Да се напише функция, която по подаден списък проверява дали всички числа в него са положителни
allPositive :: [Int] -> Bool
allPositive [] = True 
allPositive (x : xs) = if x >= 0 then allPositive xs else False

-- Задача 6: Да се напише функция, която съединява два списъка като на четните позиции слага елементите от първия списък, а на нечетните - от втория
    -- Функцията приключва, когато поне един от списъците се изпразни

concatList :: [Int] -> [Int] -> [Int]
concatList [] [] = []
concatList [] _ = []
concatList _ [] = []
concatList (x : xs) (y : ys) = [x, y] ++ concatList xs ys  

-- Задача 7: Да се напише функция, която приема два списъка и връща нов списък, чиито елементи са произведението на елементите на същата позиция в подадените списъци
    -- Пример [2,3] [1,0] -> [2, 0]

listProduct :: [Int] -> [Int] -> [Int]
listProduct [] [] = [] 
listProduct [] _ = []
listProduct _ [] = []
listProduct (x : xs) (y : ys) = x * y : listProduct xs ys 

-- Задача 8: Да се напише функция, която приема списък и връща неговата дължина
myLength :: [Int] -> Int 
myLength [] = 0
myLength (_ : xs) = 1 + myLength xs
-- Вградена функция: length

-- Задача 9: Да се напише фунцкия, която обръща спицък
reverseList :: [Int] -> [Int]
reverseList [] = []
reverseList (x : xs) = reverseList xs ++ [x]
-- Вградена функция: reverse

-- Задача 10: Да се напише функция, която връща максималния елемент на списък
-- Вградена функция: maximum
-- Вариант 1: Без отрицателни елементи
maxElement :: [Int] -> Int
maxElement [] = -1
maxElement (x : xs) = if x > res then x else res
    where res = maxElement xs 

-- Вариант 2: С отрицателни елементи
maxElement2 :: [Int] -> Int 
maxElement2 [] = error "Cannot get the maximum element of an empty list."
maxElement2 [x] = x 
maxElement2 (x : xs) = max x $ maxElement xs

-- Задача 11: Да се напише функция, която прави списък палиндром
makePalindrome :: [Int] -> [Int]
makePalindrome xs = xs ++ reverseList xs

-- Задача 12: Да се напише функция, която проверява дали списък е палиндром
isPalindrome :: [Int] -> Bool
isPalindrome [] = True 
isPalindrome (x : xs)
 | null xs = True -- null xs е същото като (xs == [])
 | x == head rev = isPalindrome $ tail rev 
 | otherwise = False
    where 
        rev = reverseList xs 

-- Задача 13: Да се напише функция, която проверява дали два списъка са еднакви
areEqual :: [Int] -> [Int] -> Bool 
areEqual [] [] = True 
areEqual [] _ = False
areEqual _ [] = False 
areEqual (x : xs) (y : ys) = x == y && areEqual xs ys
-- Вграденото равно работи и за списъци