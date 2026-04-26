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
{-# HLINT ignore "Avoid lambda using `infix`" #-}
{-# HLINT ignore "Use any" #-}

-- От миналия път:
-- Да се дефинира тип за дърво
data Tree a = TEmpty | TNode a [Tree a]
    deriving Show
-- Да се напише фунцкия, която приема дърво и връща списък от всички пътища от корена до листо
example2 :: Tree Int
example2 = TNode 1 [TNode 2 [], TNode 3 [TNode 4 []]]

getAllPaths :: Tree a -> [[a]]
getAllPaths TEmpty = []
getAllPaths (TNode a []) = [[a]]
getAllPaths (TNode a l) = map (a:) $ concatMap getAllPaths l

-- Да се дефинира тип "колебливо дърво" (ще го наричаме само дърво)
    -- Листата на дървото съдържат произволна дума
    -- Всички останали елементи са числа, които отговарят на броя на буквите, които е имало в думата

data EiTree = Node (Either Int String) [EiTree] | Empty
    deriving Show

example :: EiTree
example = Node (Left 3) [Node (Right "dog") [], Node (Left 3) [Node (Right "fish") []]]

-- Да се напише функция, която приема дърво и връща изречение, съставено от думите по листата
getSentence :: EiTree -> String
getSentence t = init (helper t) ++ "."
    where
        helper Empty = ""
        helper (Node (Right s) []) = s ++ " "
        helper (Node _ l) = concatMap helper l

-- Да се напише функция, която приема дърво и връща общия брой на буквите в дървото
getCharCountAll :: EiTree -> Int 
getCharCountAll Empty = 0 
getCharCountAll (Node (Left a) l) = a + sum (map getCharCountAll l)
getCharCountAll (Node (Right a) _) = length a 


getCharCount :: Either Int String -> Int 
getCharCount (Right a) = length a 
getCharCount (Left a) = a

-- Да се напише функция, която приема дърво и число к и връща общия брой на буквите от k-тото ниво
getCharCountK :: EiTree -> Int -> Int 
getCharCountK tree level = helper tree level 1
    where 
        helper :: EiTree -> Int -> Int -> Int 
        helper Empty _ _ = 0 
        helper (Node v l) k n = 
            if k == n then 
                getCharCount v 
            else 
                sum $ map (\t -> helper t k (n+1)) l  

-- Да се напише функция, която приема дърво и число k и връща ново дърво като броя на буквите на всеки 
-- елемент е максимално k (намаля дълъжината) 

cutTree :: EiTree -> Int -> EiTree
cutTree Empty _ = Empty
cutTree (Node v l) k = Node (helper v) (map (\t -> cutTree t k) l)
    where 
        helper :: Either Int String -> Either Int String 
        helper (Right a) = Right $ take k a
        helper (Left a) = Left (min a k) 
