import Replace

import Data.Ord
import Data.List (sortBy)
import Data.Set (Set, member, fromList)

correct :: Set String -> String -> String
correct dictionary str =
    let maybeList = replace str
        twiceList = maybeList >>= replaceEdit
        actualWords = filter (\p -> member (fst p) dictionary) twiceList
        sorted = sortBy (comparing snd) actualWords
    in  fst $ head sorted


main :: IO ()
main = do
    file <- readFile "wordsEN.txt"
    let words = fromList (lines file)
    putStrLn $ show $ member "hello" words -- force evaluation of the set
    putStrLn $ correct words "grapefruur"