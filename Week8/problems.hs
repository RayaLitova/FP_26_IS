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
{-# HLINT ignore "Use any" #-}

-- Да се дефинира тип за двоично дърво
data Btree a = Empty | Node a (Btree a) (Btree a)
    deriving Show 

example :: Btree Int 
example = Node 1 (Node 2 Empty Empty) (Node 3 (Node 4 Empty Empty) (Node 5 Empty Empty))

-- Да се напише функция, която намира височината на дървото
height :: Btree a -> Int 
height Empty = 0 
height (Node _ l r) = 1 + max (height l) (height r)

-- Да се напише функция, която намира броя на всички елементи на дървото
countNodes :: Btree a -> Int 
countNodes Empty = 0 
countNodes (Node _ l r) = 1 + countNodes l + countNodes r

-- Да се напише функция, която проверява дали дадена стойност се съдържа в дървото
findValue :: Eq a => Btree a -> a -> Bool
findValue Empty _ = False 
findValue (Node a l r) b = b == a || findValue l b || findValue r b

-- Да се напише фунцкия, която приема дърво и връща списък от всички пътища от корена до листо
getPaths :: Btree a -> [[a]]
getPaths Empty = []
getPaths (Node a Empty Empty) = [[a]]
getPaths (Node a l r) = map (a : ) $ getPaths l ++ getPaths r

-- Да се напише функция, която приема списък и връща BST
insert :: Btree Int -> Int -> Btree Int 
insert Empty a = Node a Empty Empty 
insert (Node x l r) a = if x > a then Node x (insert l a) r else Node x l (insert r a)

createBST :: [Int] -> Btree Int
createBST [] = Empty
createBST (x : xs) = foldl insert (Node x Empty Empty) xs

createBST2 :: [Int] -> Btree Int
createBST2 [] = Empty
createBST2 (x : xs) = helper xs (Node x Empty Empty)
    where 
        helper :: [Int] -> Btree Int -> Btree Int 
        helper [] b = b 
        helper (y : ys) b = helper ys (insert b y)

-- Да се дефинира тип за дърво (не двоично)
data Tree a = TEmpty | TNode a [Tree a]
    deriving Show

example2 :: Tree Int 
example2 = TNode 1 [TNode 2 [], TNode 3 [TNode 4 []]]

-- Да се напише функция, която намира височината на дървото
tHeight :: Tree a -> Int
tHeight TEmpty = 0
tHeight (TNode _ []) = 1
tHeight (TNode _ l) = 1 + maximum (map tHeight l) 

-- Да се напише функция, която намира броя на всички елементи на дървото
tCount :: Tree a -> Int 
tCount TEmpty = 0
tCount (TNode _ l) = 1 + sum (map tCount l)

-- Да се напише функция, която проверява дали дадена стойност се съдържа в дървото
tFindValue :: Eq a => a -> Tree a -> Bool
tFindValue _ TEmpty = False
tFindValue b (TNode a l) = a == b || or (map (tFindValue b) l)   

-- За домашно:
-- Да се напише фунцкия, която приема дърво и връща списък от всички пътища от корена до листо
