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
{-# HLINT ignore "Avoid lambda" #-}
import GHC.Generics (C)
{-# HLINT ignore "Eta reduce" #-}

-- map, filter, foldl, foldr

-- Игра с карти:
-- Задача 1: Да се дефинира тип за карта за игра. Всяка карта има цвят и сила
data Color = Spade | Club | Diamond | Heart 
    deriving Show

type Card = (Color, Int)

-- Задача 2: Да се дефинира тип за играч. Всеки играч има име и списък от карти.

-- При тази дефиниция получаваме функциите: name :: Player -> String и cards :: Player -> [Card]
data Player = Player {name :: String, cards :: [Card]}
    deriving Show

-- Задача 3: Да се напише функция, която приема играч и връща сумата от силата на картите му
getCardSum :: Player -> Int
getCardSum p = foldl (\acc c -> acc + snd c) 0 $ cards p
-- Втори валиден вариант:
-- getCardSum p = foldl (\acc (_, r) -> acc + r) 0 $ cards p

example :: [Player]
example = [Player "a" [(Spade, 5), (Spade, 8)], Player "b" [(Heart, 3), (Heart, 4)]]

-- Задача 4: Да се напише функция, която приема списък от играчи и връща списък от сумите на картите на всеки
getAllSum :: [Player] -> [Int]
getAllSum ps = map getCardSum ps

-- Задача 5: Да се напише функция, която приема число и списък от играчи и връща списък само от тези, чиято сума на картите е по-висока от подаденото число
filterCardStrength :: Int -> [Player] -> [Player]
filterCardStrength n ps = filter (\p -> getCardSum p >= n) ps

-- Wordle:
-- Задача 1: Да се дефинира тип word
type MyWord = String

-- Задача 2: Да се напише функция, която приема дума и буква и проверява дали буквата се съдържа в думата
isInWord :: Char -> MyWord -> Bool 
isInWord c w = c `elem` w

-- Рекурсивен вариант
isInWordRec :: MyWord -> Char -> Bool
isInWordRec [] _ = False
isInWordRec (x : xs) c = x == c || isInWordRec xs c 

-- Задача 3: Да се напише функция, която приема списък от думи и буква и връща само тези думи, в които се съдържа буквата
filterIsIn :: [MyWord] -> Char -> [MyWord]
filterIsIn ws c = filter (isInWord c) ws 

-- Рекурсивен вариант
filterIsInRec :: [MyWord] -> Char -> [MyWord]
filterIsInRec [] _ = []
filterIsInRec (x : xs) c = if isInWord c x then x : res else res
    where res = filterIsInRec xs c

-- Задача 4: Да се напише функция, която приема списък от думи и буква и връща само тези думи, в които НЕ се съдържа буквата
filterNotIn :: [MyWord] -> Char -> [MyWord]
filterNotIn ws c = filter (\w -> not $ isInWord c w) ws 

-- Задача 5: Да се напише функция, която приема списък от думи и два списъка с букви. 
-- Функцията трябва да връща списък от думите, в които се съдържат всички букви от първия списък, но не се съдържат буквите от втория.
filterWords :: [MyWord] -> [Char] -> [Char] -> [MyWord]
filterWords ws (c1 : c1s) (c2 : c2s) = filterWords (filter (\w -> isInWord c1 w && not (isInWord c2 w)) ws) c1s c2s
filterWords ws [] [] = ws 
filterWords ws [] (c2 : c2s) = filterWords (filter (\w -> not (isInWord c2 w)) ws) [] c2s
filterWords ws (c1 : c1s) [] = filterWords (filter (\w ->  isInWord c1 w) ws) [] c1s

-- zip
-- Ако направим задачата така, задължаваме двата подадени списъка да са с равна дължина!
filterWords2 :: [MyWord] -> [Char] -> [Char] -> [MyWord]
filterWords2 ws c1s c2s = foldl (\acc (c1, c2) -> filterNotIn (filterIsIn acc c1) c2) ws (zip c1s c2s) 