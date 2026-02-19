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

{-# HLINT ignore "Redundant if" #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Use guards" #-}

-- Какво е функционален език?
    -- всичко е pure
        -- Какво е pure?
            -- Функция, която при еднакъв вход винаги връща еднакъв резултат.
        -- Какво е страничен ефект?
            -- Input, Output, Random, Четене от файл и т.н.
    -- всичко е immutable
        -- Какво означава immutable?
            -- Стойностите не могат да бъдат променяни

-- Вградени функции, показани на това упражнение:
-- div a b -> целочислено делене (а / b)
-- rem a b -> връща остатъка при a/b (а % b)
-- round -> закръгля надолу дробно число
-- ceiling -> закръгля нагоре дробно число 
-- not -> обръща булева стойност (not True == False)

-- Задачи:

---- Функции

-- Задача 1: Константа 5
five :: Int
five = 5

-- Задача 2: Функция, която приема число n и връща n+1
add1 :: Int -> Int
add1 n = n + 1

-- Задача 3: Сума на 2 числа (Подаваме числа m и n и връщаме n + m)
mySum :: Int -> Int -> Int
mySum m n = n + m

-- Задача 4: Функция, която проверява дали подадено число е равно на 5

-- Вариант 0: Pattern matching
    -- Pattern matching наричаме поставянето на конкретни стойности на мястото на параметрите
isFive :: Int -> Bool
isFive 5 = True
isFive _ = False

-- Вариант 1: с if
is5 :: Int -> Bool
is5 a = 
    if a == 5 then 
        True 
    else 
        False 

-- Вариант 2: без if
is5' :: Int -> Bool
is5' a = a == 5

-- Вариант 3: с five
is5'' :: Int -> Bool
is5'' a = a == five


---- Рекурсия

-- Задача 5: Фибоначи (Подаваме кое по ред число на Фибоначи искаме да получим (Пример: fib 3 = 2))
fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fib (n-2) + fib (n-1)

-- Задача: Факториел (приема число n и връща n!)
fac :: Int -> Int 
fac 1 = 1
fac n = n * fac (n-1)

-- Задача: Сума на квадрати от 0 до n
    -- Подаваме числото n и получаваме като резултат (n*n) + ((n-1) * (n-1)) + ... + (2 * 2) + (1 * 1) + 0
sumSquare :: Int -> Int
sumSquare 0 = 0
sumSquare n = n * n + sumSquare (n-1)

-- Задача: Странна сума (Приема 2 числа и връща сума от 0 до по-малкото от 2те като на всяка стъпка намаля и двете с единица)
    -- Всяко извикване на функцията добавя към резултата сумата на 2-те подадени числа. След това ги намаля с едно и извиква себе си рекурсивно. 
    -- Функцията приключва, когато поне едното число стане равно на 0
    -- Пример: Подаваме 2 и 3 -> Функцията връща (2 + 3) + (1 + 2) + (0 + 1)
    -- Пример: Подаваме 1 и 4 -> Функцията връща (1 + 4) + (0 + 3)
funSum :: Int -> Int -> Int 
funSum 0 b = b 
funSum a 0 = a 
funSum a b = a + b + funSum (a-1) (b-1)

-- Задача: Подаваме 2 числа (а и b) -> Функцията връща сумата на числата от а до b включително
    -- Пример: a = 3, b = 5 -> Резултат: 3 + 4 + 5 = 12
sumRange :: Int -> Int -> Int 
sumRange a b = 
    if a == b then 
        a
    else 
        a + sumRange (a + 1) b   


-- where и let
-- Задача 6: При подадени 2 числа проверява дали 1вото е равно на 2рото + 1

-- Вариант 1: с let
isNext :: Int -> Int -> Bool
isNext a b = 
    let c = a - 1 
    in c == b 

-- Вариант 2: с where
isNext' :: Int -> Int -> Bool
isNext' a b = c == p
    where 
        c = a - 1 
        p = b

        
-- Задача 7: Проверка дали число е просто
isPrime :: Int -> Bool
isPrime 1 = False
isPrime n = not (hasDivisor n (div n 2))
    where 
        hasDivisor :: Int -> Int -> Bool 
        hasDivisor _ 1 = False
        hasDivisor a b = 
            if rem a b == 0 then
                True 
            else 
                hasDivisor a (b-1) 

-- Задача 8:
    -- Да се декларира и дефинира функция, която приема точки живот на играч (int), номер на действие (int) и damage (int).
    -- Тя трябва да изпълнява действието, съответстващо на избора на играча, и да връща новите точки живот (int):
        -- 1 -> Точките живот намалят с damage
        -- 2 -> Точките живот се увеличават с damage
        -- 3 -> Точките живот се намалят с damage 2 пъти
        -- 4 -> Точките живот се намалят с damage числото на Фибоначи
            -- Пример: damage = 6 -> Tочките живот се намалят с fib 6 = 8
        -- 5 -> Ако текущите точки живот са по-малко от damage -> Увеличаваме с damamge. В противен случай - намаляме с damage
        -- 6 -> 
            -- Ако текущите точки живот са просто число - Намаляме с 20
            -- Ако текущите точки живот са четно число - Увеличаваме с 10
            -- В противен случай намаляме с най-малкия делител на точките живот, различен от 1

    --   HP -> action num -> damage -> new HP
action :: Int -> Int -> Int -> Int 
action hp a dmg
    | a == 1 = hp - dmg
    | a == 2 = hp + dmg
    | a == 3 = hp - 2 * dmg 
    | a == 4 = hp - fib dmg
    | a == 5 = if hp < dmg then hp + dmg else hp - dmg 
    | a == 6 = 
        if isPrime hp then 
            hp - 20 
        else if rem hp 2 == 0 then 
            hp + 10 
        else 
            getSmallestDivisor hp 2 
    | otherwise = hp
    where 
        getSmallestDivisor :: Int -> Int -> Int 
        getSmallestDivisor n b = 
            if b >= (div n 2) then 
                1 
            else if (rem n b) == 0 then  
                b
            else 
                getSmallestDivisor n (b+1) 










