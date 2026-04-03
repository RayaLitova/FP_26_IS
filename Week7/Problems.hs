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
-- Да се напише функция, която генерира дърво от списък
-- Да се напише функция, която превръща дърво в списък
-- Да се напише функция, която намира сумата на всички числа в дървото
-- Да се напише функция, която връща най-дясното листо на дървото
-- Да се напише функция, която добавя нова стойност като най-ляво листо 