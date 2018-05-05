import Data.List (sortBy, findIndex, elemIndex)
import Data.Ord
import Data.Set (Set, member, fromList)

-------------------------------------------------------------------------------

keyboard = ["qwertyuiop", "asdfghjkl", " zxcvbnm"]
letters = "abcdefghijklmnopqrstuvwxyz"

getCoord :: Char -> Maybe (Int, Int)
getCoord c = do
    row <- findIndex (\row -> elem c row) keyboard
    col <- elemIndex c (keyboard !! row)
    Just (row, col)

-------------------------------------------------------------------------------

insertAt :: String -> Char -> Int -> String
insertAt str char index = (take index str) ++ [char] ++ (drop index str)

insert :: String -> Char -> [String]
insert str char = map (insertAt str char) [0..(length str)]

insertAll :: String -> [String]
insertAll str = foldl (++) [] $ map (insert str) letters

-------------------------------------------------------------------------------

replaceAt :: String -> Char -> Int -> (String, Int)
replaceAt "" _ _ = ("", 0)
replaceAt str char 0 = ([char] ++ (tail str), distance)
    where distance = dist char (head str)
replaceAt str char index = ([head str] ++ res, distance)
    where (res, distance) = replaceAt (tail str) char (index - 1)

replace :: String -> Char -> [(String, Int)]
replace str char = map (replaceAt str char) [0..((length str) - 1)]

replaceAll :: String -> [(String, Int)]
replaceAll str = foldl (++) [] $ map (replace str) letters

-------------------------------------------------------------------------------

dist :: Char -> Char -> Int
dist char1 char2 = 
    let 
        Just (x1, y1) = getCoord char1
        Just (x2, y2) = getCoord char2
        xDist = abs (x2 - x1)
        yDist = abs (y2 - y1)
    in
        xDist + yDist


distInsert :: Char -> Char -> Char -> Int
distInsert before after i = min (dist before i) (dist after i)

-------------------------------------------------------------------------------

correct :: Set String -> String -> String
correct dictionary str =
    let
        maybeList = replaceAll str
        actualWords = filter (\p -> member (fst p) dictionary) maybeList
        sorted = sortBy (comparing snd) actualWords
    in
        fst $ head sorted


main :: IO ()
main = do
    file <- readFile "wordsEN.txt"
    let words = fromList (lines file)
    putStrLn "Done with input"
    putStrLn $ correct words "grapefruut"








