module Delete where

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

fromMiddle :: Char -> Edit -> Edit
fromMiddle prev (b:c:rest, score) = (c:rest, score + threeDist prev b c)

fromFront :: Edit -> Edit
fromFront (a:b:rest, score) = (b:rest, score + dist a b)

fromEnd :: Char -> Edit -> Edit
fromEnd prev (b:[], score) = ([], score + dist prev b)

fromSplit :: (String, String) -> Int -> Edit
fromSplit ("",    back) score = fromFront (back, score)
fromSplit (front,  [b]) score = (front ++ newRest, newScore)
    where (newRest, newScore) = fromEnd (last front) ([b], score)
fromSplit (front, back) score = (front ++ newRest, newScore)
    where (newRest, newScore) = fromMiddle (last front) (back, score)
    
deleteEdit :: Edit -> [Edit]
deleteEdit (str, score) = 
    let strlen = (length str) - 1
        splits = [ splitAt i str | i <- [0..strlen] ]
    in  [ fromSplit s score | s <- splits ]

-------------------------------------------------------------------------------

delete :: String -> [Edit]
delete str = deleteEdit (str, 0)




