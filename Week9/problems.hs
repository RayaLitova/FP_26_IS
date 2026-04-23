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

-- От миналия път:
-- Да се дефинира тип за дърво
-- Да се напише фунцкия, която приема дърво и връща списък от всички пътища от корена до листо

-- Да се дефинира тип "колебливо дърво" (ще го наричаме само дърво)
    -- Листата на дървото съдържат произволна дума
    -- Всички останали елементи са числа, които отговарят на броя на буквите, които е имало в думата

-- Да се напише функция, която приема дърво и връща изречение, съставено от думите по листата
-- Да се напише функция, която приема дърво и връща общия брой на буквите в дървото
-- Да се напише функция, която приема дърво и число к и връща общия брой на буквите от k-тото ниво
-- Да се напише функция, която приема дърво и число k и връща ново дърво като броя на буквите на всеки елемент е максимално k (намаля дълъжината) 
