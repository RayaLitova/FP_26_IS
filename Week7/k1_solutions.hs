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
{-# HLINT ignore "Eta reduce" #-}

-- Вариант 1
-- Задача 1
{- Нека е даден списък от числа L и някой негов елемент x.  “Ляв минимум” на елемента x в списъка L 
наричаме най-малкото число в L, което се намира вляво от x, включително x.
Дефинирайте функция leftMin :: [Int] -> [Int], която получава списък от цели числа и връща нов 
списък със същата дължина, в който всяко от числата е заменено с неговия ляв минимум. -}

-- Задача 2
{- 
Дефинирайте функция 
kthTransformed :: [Int] -> (Int -> Int) -> (Int -> Bool) -> Int -> Int,
която приема списък от цели числа (xs), функция f, предикат p, и естествено число k.
kthTransformed да прилага f над елементите на xs, да филтрира получения списък според p и да 
върне k-тото по големина (k-тото най-голямо) число, което се получава. Ако такова число не 
съществува, да се породи грешка (чрез error "No such number").
-}

-- Вариант 2
-- Задача 1
{-
Нека е даден списък от числа L и някой негов елемент x.  “Дясна сума” на елемента x в списъка L 
наричаме сумата на числата в L, които се намират вдясно от x, включително x.
Дефинирайте функция rightSum :: [Int] -> [Int], която получава списък от числа и връща нов 
списък със същата дължина, в който всяко от числата е заменено с дясната му сума.
-}

-- Задача 2
{-
Дефинирайте функция
kthOriginal :: [Int] -> (Int -> Int) -> (Int -> Bool) -> Int -> Int, 
която приема списък от числа xs, функция f, предикат p и число k. Функцията трябва да намери 
k-тото най-малко число от xs, за което е в сила, че след прилагане на f върху него, полученият 
резултат изпълнява предиката p. Ако такова число не съществува, да се породи грешка 
(чрез error "No such number").
-}