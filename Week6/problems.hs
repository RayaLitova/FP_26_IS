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
{-# HLINT ignore "Use isAsciiUpper" #-}
import Data.Char (ord, chr)
import Data.Maybe (mapMaybe)
import Text.ParserCombinators.ReadP (get)
import GHC.ConsoleHandler (installHandler)

-- Въпроси?

mergesort :: [Int] -> [Int]
mergesort [] = []
mergesort [x] = [x]
mergesort l = merge (mergesort (take mid l)) (mergesort (drop mid l))
    where mid = length l `div` 2

merge :: [Int] -> [Int] -> [Int]
merge [] l = l
merge l [] = l
merge l1@(x : xs) l2@(y : ys) = if x > y then y : merge l1 ys else x : merge xs l2

-- За домашно от миналия път:
-- Задача 3: Да се напише функция, която приема списък и число n, и връща нов списък от n-те най-големи числа в списъка. 
--  Ако списъкът има по-малко от n елемента да връща грешка

nBiggest :: [Int] -> Int -> [Int]
nBiggest l n =
    if length l < n then
        error "greshka"
    else
        take n $ reverse $ mergesort l
        -- drop (length l - n) $ mergesort l


-- Задача 8: Да се напише обратната функция (superWeakDecode) 
superWeakDecode :: String -> String
superWeakDecode [] = []
superWeakDecode (x : xs) =
    if x >= 'A' && x <= 'Z' then
        chr (ord x - ord 'A' + ord 'a') : superWeakDecode xs
    else
        replicate n (chr (ord x - n)) ++ superWeakDecode (tail xs)
    where n = read [head xs]

-- Задача 1: Да се дефинира типа Maybe
data MyMaybe = MyJust Int | MyNothing
    deriving Show

-- Задача 1.1: Да се напише функцията safeHead
safeHead :: [Int] -> MyMaybe
safeHead [] = MyNothing
safeHead (x : _) = MyJust x

myMapMaybe :: [Int] -> (Int -> Maybe Int) -> [Int]
myMapMaybe [] _ = []
myMapMaybe (x : xs) f = helper (f x)
    where
        helper :: Maybe Int -> [Int]
        helper (Just y) = y : myMapMaybe xs f
        helper Nothing = myMapMaybe xs f

    --case f x of 
    --    Just y -> y : myMapMaybe xs f 
    --    Nothing -> myMapMaybe xs f

-- Задача 1.2: Да се напише функцията mapMaybe 

-- Задача 2: Генерирайте всички цели положителни числа
z :: [Int]
z = [1 .. ]

-- Задача 2.1: Генерирайте всички цели четни числа
zEven :: [Int]
zEven = [x | x <- [1..], even x]
-- Задача 2.2: Генерирайте всички цели четни числа по-големи от подадено n
zEvenBiggerThan :: Int -> [Int]
zEvenBiggerThan n = [x | x <- [1..], even x, x > n]

allPairs :: [(Int, Int)]
allPairs = [(x, y) | x <- [1..5], y <- [1..5]]

-- Задача 3: Дефинирайте тип Potion. Той трябва да има: тип (Healing, Poison, Effect)
-- За тази задача точки живот ще наричаме стойност от тип Int
-- Типовете се различават по следния начин: 
    -- Healing - увеличава точките живот с число
    -- Poison - намаля точките живот с число
    -- Effect - прилага функция върху точките живот

data Potion = Healing Int | Poison Int | Effect (Int -> Int)

instance Show Potion where 
    show :: Potion -> String 
    show (Healing x) = "Healing " ++ show x 
    show (Poison x) = "Poison " ++ show (-x)
    show (Effect f) = "Effect for 1: " ++ show (f 1)


-- Задача 4: Да се напише функция, която приема Potion и точки живот и изпълнява действието на Potion-а върху 
--точките живот.
    -- Ако точките живот ще паднат под 0 да върне Nothing
type HP = Int
apply :: Potion -> HP -> Maybe HP
apply (Healing x) hp = Just (hp + x)
apply (Poison x) hp = if hp >= x then Just (hp - x) else Nothing
apply (Effect f) hp = if f hp >= 0 then Just (f hp) else Nothing

-- Задача 5: Да се напише функция, която комбинира 2 Potions. (т.е създава нов Potion, 
--който прилага ефектите им последователно)
combineTwo :: Potion -> Potion -> Potion
combineTwo (Healing x) (Poison y) = Effect ((\a -> a - y) . (+x))
combineTwo (Healing x) (Effect f) = Effect (f . (+x))
combineTwo (Healing x) (Healing y) = Effect ((+x) . (+y))
combineTwo (Poison x) (Healing y) = Effect ((\a -> a - x) . (+y))
combineTwo (Poison x) (Effect f) = Effect (f . (\a -> a - x))
combineTwo (Poison x) (Poison y) = Effect ((\a -> a - x) . (\a -> a - y))
combineTwo (Effect f) (Healing x) = Effect ((+x) . f)
combineTwo (Effect f) (Poison x) = Effect ((\a -> a - x) . f)
combineTwo (Effect f) (Effect g) = Effect (g . f)

-- Задача 6: Да се напише функция, която приема списък от Potion и ги комбинира
combinePotions :: [Potion] -> Potion
combinePotions [] = error "error"
combinePotions (x : xs) = foldl combineTwo x xs

combinePotionsRec :: [Potion] -> Potion
combinePotionsRec [] = error "error"
combinePotionsRec [x] = x
combinePotionsRec (x : y : xs) = combinePotionsRec $ combineTwo x y : xs

-- Задача 7: Да се напише функция, която приема списък от Potion и списък от точки живот.
    -- Прилага всички ефекти върху всички точки живот и връща само тези, които са по-големи от 0
applyAll :: [Potion] -> [HP] -> [HP]
applyAll ps hps = filter (>0) $ mapMaybe (apply (combinePotions ps)) hps

-- Задача 8: Да се напише функция, която приема списък от Potion и списък от точки живот, 
-- прилага функцията от задача 7 и връща 2рото най-голямо число.
getSecondHighest :: [Potion] -> [HP] -> HP
getSecondHighest ps hps = reverse (mergesort $ applyAll ps hps) !! 1

-- Задача 9: Да се напише функция, която приема списък от Potion и връща списък от наредени двойки от 
--всички възможни комбинации на 2 от тях
getAllPotionPairs :: [Potion] -> [(Potion, Potion)]
getAllPotionPairs ps = [(x, y) | x <- ps, y <- ps]

-- Задача 10: Да се дефинира тип за матрица от Potion (за следващите задачи наричаме типа просто матрица)
-- Задача 11: Да се напише функция, която приема матрица и връща елементите по главния диагонал
-- Задача 12: Да се напише функция, която приема две матрици и комбинира елементите на еднакви позиции
-- Задача 13: Да се напише функция, която приема матрица и връща един комбиниран Potion
-- Задача 14: Да се напише функция, която приема матрица и я транспонира




