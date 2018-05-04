module Replace where

import qualified Keyboard as Key

-------------------------------------------------------------------------------

type Edit = (String, Int) -- String is the edited string, Int is the score

dist :: Char -> Char -> Int
dist char1 char2 = 
    let Just (x1, y1) = Key.getCoord char1
        Just (x2, y2) = Key.getCoord char2
        xDist = abs (x2 - x1)
        yDist = abs (y2 - y1)
    in  xDist + yDist

-------------------------------------------------------------------------------

replaceHead :: Edit -> Char -> Edit
replaceHead ("",  score) new = ("", score)
replaceHead (str, score) new = ([new] ++ (tail str), distance + score)
    where distance = dist new (head str)

fromSplit :: (String, String) -> Int -> Char -> Edit
fromSplit (front, back) score new = (front ++ newBack, newScore)
    where (newBack, newScore) = replaceHead (back, score) new

replaceChar :: Edit -> Char -> [Edit]
replaceChar (str, score) new = 
    let strlen = (length str) - 1
        splits = [ splitAt i str | i <- [0..strlen] ]
    in  [ fromSplit s score new | s <- splits ]

-------------------------------------------------------------------------------

replace :: String -> [Edit]
replace str = replaceEdit (str, 0)

replaceEdit :: Edit -> [Edit]
replaceEdit edit = foldl (++) [] $ map (replaceChar edit) Key.letters