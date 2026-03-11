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
import GHC.Float (int2Double)
{-# HLINT ignore "Use map" #-}
{-# HLINT ignore "Eta reduce" #-}

-- Дефиниране на типове
-- data
data Test = Test1 | Test2 Int Int | Test3 (Int, Int) | Test4 [String] | Test5 Float
    deriving (Show, -- За да можем да принтираме в терминал
                Eq -- За да можем да сравняваме дали елементите са равни
            )
-- newtype
newtype TTest = MkTTest Int
-- type
type TTTest = Int

-- Ако оградим префиксна функция с `, тя става инфиксна: 
    -- Пример div 2 2 == 2 `div` 2
-- Ако оградим инфиксен оператор със (), той става префиксен
    -- Пример 1 + 2 == (+) 1 2

-- Важно!!!
-- f :: a -> b -> c 
-- f a :: b -> c
-- f a b :: c
-- Пример: 
-- (+) :: Int -> Int -> Int 
-- (+) 1 :: Int -> Int
-- (+) 1 2 :: Int

-- Задача 1: Да се дефинира тип Point, който представлява наредена двойка от целочислени координати x и y
type Point = (Int, Int)

-- Задача 2: Да се напише функция, която приема две точки и връща точката, която се намира посредата 
getMiddle :: Point -> Point -> Point 
getMiddle (x1, y1) (x2, y2) = ((x1 + x2) `div` 2, (y1 + y2) `div` 2)

-- Задача 3: Да сe напише функция, която приема списък от точки и връща точката с най-голям х
maxx :: [Point] -> Point 
maxx [] = error "Empty list"
maxx [p] = p
maxx ((x, y) : xs) = if x > x2 then (x, y) else (x2, y2)
    where 
        (x2, y2) = maxx xs

-- Задача 4: Да се дефинира тип Animal, което има стойности Cow, Cat или Dog
data Animal = Cat | Cow | Dog 
    deriving Show

-- Задача 5: Да се напише функция, която приема животно и връща String, който е звука, който издава животното
getSound :: Animal -> String
getSound Cat = "Meow"
getSound Cow = "Moo"
getSound Dog = "Woof"

-- Задача: Да се напише функция, която приема животно и връща следващото животно в реда, в който са дефинирани в типа
getNextAnimal :: Animal -> Animal
getNextAnimal Cat = Cow 
getNextAnimal Cow = Dog 
getNextAnimal Dog = Cat

-- Задача 6: Да се дефинира тип Shape, който има стойности Circle и Rectangle
    -- Кръгът има радиус, а правоъгълникът - дължина на страните
data Shape = Circle Int | Rectangle Int Int 
    deriving Show

-- Разликата между float и double е в прецизността => по-правилно е да ползваме double за сметки

-- Задача 7: Да се напише функция, която приема фигура и връща нейното лице 
-- int2Double - преобразува int към double
getArea :: Shape -> Double
getArea (Circle n) = 2 * pi * int2Double n
getArea (Rectangle x y) = int2Double x * int2Double y

-- Задача 8: Да се напише функция, която приема две фигури и връща нова фигура, чиито размери са сумата на двете фигури
    -- Пример: Circle 5, Circle 6 -> Circle 11
createShape :: Shape -> Shape -> Shape 
createShape (Rectangle x1 y1) (Rectangle x2 y2) = Rectangle (x1 + x2) (y1 + y2)
createShape (Circle r1) (Circle r2) = Circle (r1 + r2)
createShape _ _ = error "Different shapes"

-- Задача 9: Да се напише функция, която приема фигура и връща нова фигура по следното правило:
    -- Circle x -> Rectangle x/2 x/2
    -- Rectangle x y -> Circle x+y
newShape :: Shape -> Shape
newShape (Circle r) = Rectangle (r `div` 2) (r `div` 2)
newShape (Rectangle x y) = Circle (x+y)

-- Задача 10: Да се напише функция, която приема списък от фигури и връща списъка като върху всеки елемент прилага функцията от задача 9
mapNewShape :: [Shape] -> [Shape]
mapNewShape [] = []
mapNewShape (x : xs) = newShape x : mapNewShape xs

-- Какво са функции от по-висок ред? 
    -- Функции, които приемат друга функция като параметър
    -- Стандартно операторът (->) е дясноасоциативен т.е:
        -- f :: (А -> (B -> C)) 
            -- буквално е функция, която приема стойност от тип А и връща функция (B -> C)
            -- (ние я четем като функция, която приема 2 параметъра от тип А и B и връща стойност от тип C)
            -- f a :: B -> C - функция, която приема стойност от тип B и връща стойност от тип C 
    -- Ако сложим скоби:
        -- f :: (A -> B) -> C
            -- f е функция, която приема функция от тип (А -> B) и връща стойност от тип С

-- Задача 11: Да се напише функцията map за типа Shape
-- map - приема списък и функция и прилага функцията върху всеки от елементите на списъка
-- map :: (a -> b) -> [a] -> [b] (a и b не е нужно да са различни типове)
myMap :: (Shape -> Shape) -> [Shape] -> [Shape]
myMap _ [] = []
myMap f (x : xs) = f x : myMap f xs 

-- Задача 12: Да се направи 10-та задача, използвайки map
mapNewShape2 :: [Shape] -> [Shape]
mapNewShape2 shapes = myMap newShape shapes

-- Задача 13: Да се напише функция, която приема списък от фигури и увеличава всички дължини с 1
increaseWithOne :: [Shape] -> [Shape]
increaseWithOne shapes = myMap helper shapes
    where 
        helper :: Shape -> Shape
        helper (Circle n) = Circle (n+1)
        helper (Rectangle x y) = Rectangle (x + 1) (y + 1)

-- Задача 14: Да се напише функция, която приема списък от числа и число n и връща нов списък като всеки елемент на списъка е събран с n
increaseWithN :: [Int] -> Int -> [Int]
increaseWithN xs n = map (+n) xs
-- (+n) :: Int -> Int  