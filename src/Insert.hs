module Insert where

import qualified Keyboard as Key

-------------------------------------------------------------------------------

type Edit = (String, Int) -- String is the edited word, Int is the score

dist :: Char -> Char -> Int
dist char1 char2 = 
    let Just (x1, y1) = Key.getCoord char1
        Just (x2, y2) = Key.getCoord char2
        xDist = abs (x2 - x1)
        yDist = abs (y2 - y1)
    in  xDist + yDist

threeDist :: Char -> Char -> Char -> Int
threeDist before after ins = min (dist before ins) (dist ins after)

-------------------------------------------------------------------------------

fromSplit :: (String, String) -> Int -> Char -> Edit
fromSplit ("",    back) score new = ([new] ++ back, score + dist new (head back))
fromSplit (front,   "") score new = (front ++ [new], score + dist new (last front))
fromSplit (front, back) score new = (front ++ [new] ++ back, newScore)
    where newScore = score + threeDist (last front) (head back) new

insertChar :: Edit -> Char -> [Edit]
insertChar (str, score) new = 
    let strlen = (length str)
        splits = [ splitAt i str | i <- [0..strlen] ]
    in  [ fromSplit s score new | s <- splits ]

-------------------------------------------------------------------------------

insert :: String -> [Edit]
insert str = insertEdit (str, 0)

insertEdit :: Edit -> [Edit]
insertEdit edit = foldl (++) [] $ map (insertChar edit) Key.letters




