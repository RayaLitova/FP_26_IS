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

-- Организационни въпроси: Искате ли да преместим упражнението петък от 10?

-- Какво е функционален език?
    -- всичко е pure
        -- Какво е pure?
        -- Какво е страничен ефект?
    -- всичко е immutable
        -- Какво означава immutable?

-- Задачи:

---- Функции

-- Задача 1: Симулация на константа 5
five :: Int
five = undefined

-- Задача 2: Функция, която приема число n и връща n+1
add1 :: Int -> Int
add1 = undefined

-- Задача 3: Сума на 2 числа
mySum :: Int -> Int -> Int
mySum = undefined

-- Задача 4: Функция, която проверява дали подадено число е равно на 5

-- Вариант 0: Pattern matching
isFive :: Int -> Bool
isFive = undefined

-- Вариант 1: с if
is5 :: Int -> Bool
is5 = undefined

-- Вариант 2: без if
is5' :: Int -> Bool
is5' = undefined

-- Вариант 3: с five
is5'' :: Int -> Bool
is5'' = undefined

---- Рекурсия

-- Задача 5: Фибоначи
fib :: Int -> Int
fib = undefined

-- where и let
-- Задача 6: При подадени 2 числа проверява дали 1вото е равно на 2рото + 1
-- Вариант 1: с let
isNext :: Int -> Int -> Bool
isNext = undefined

-- Вариант 2: с where
isNext' :: Int -> Int -> Bool
isNext' = undefined

-- Задача 7: Проверка дали число е просто
isPrime :: Int -> Bool
isPrime = undefined

-- Задача 8: (да се използват guards)
    -- Да се декларира и дефинира функция, която приема точки живот на играч (int) и номер на действие (int).
    -- Тя трябва да изпълнява десйтвието, съответстващо с избора на играча и да връща новите точки живот (int):
        -- 1 -> take damage
        -- 2 -> heal
        -- 3 -> take damage 2 times
        -- 4 -> take damage equal to the fifth number of fibonacci
        -- 5 -> if your health is below 5 : heal for 5, else : take 5 damage
        -- 6 -> if your health is a prime number take 20 damage, 
                -- if your health is divisble by 2 : heal for 10, 
                -- otherwise take damage equal to the smallest divisor






