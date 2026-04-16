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

-- Да се дефинира тип за двоично дърво
data BTree a = Empty | Node a (BTree a) (BTree a)
    deriving Show

-- Да се напише функция, която генерира дърво от списък
generateTree :: [a] -> BTree a 
generateTree [] = Empty
generateTree (x : xs) = Node x (generateTree (take (length xs `div` 2) xs)) (generateTree (drop (length xs `div` 2) xs))

-- Да се напише функция, която превръща дърво в списък
generateList :: BTree a -> [a]
generateList Empty = [] 
generateList (Node x left right) = x : generateList left ++ generateList right

-- Да се напише функция, която намира сумата на всички числа в дървото
sumTree :: BTree Int -> Int 
sumTree Empty = 0 
sumTree (Node x l r) = x + sumTree l + sumTree r

-- Да се напише функция, която връща най-дясното листо на дървото
getRightLeaf :: BTree a -> a 
getRightLeaf Empty = error "oops"
getRightLeaf (Node x _ Empty) = x
getRightLeaf (Node _ _ r) = getRightLeaf r