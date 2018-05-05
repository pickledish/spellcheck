import System.Environment

import Replace (replace, replaceEdit, Edit)
import Insert (insert, insertEdit)
import Delete (delete, deleteEdit)

import Data.Ord
import Data.List (sortBy, nub)
import Data.Set (Set, member, fromList)

applyEdits :: Edit -> [Edit]
applyEdits edit = (replaceEdit edit) ++ (insertEdit edit) ++ (deleteEdit edit)

applyEditsStr :: String -> [Edit]
applyEditsStr str = applyEdits (str, 0)

correctList :: Set String -> String -> [Edit]
correctList dictionary str =
    let maybeList = applyEditsStr str
        twiceList = maybeList >>= applyEdits
        realWords = [ p | p <- twiceList, member (fst p) dictionary ]
    in  sortBy (comparing snd) (nub realWords)

correct :: Set String -> String -> String
correct dictionary str = fst $ head (correctList dictionary str)

main :: IO ()
main = do
    args <- getArgs
    file <- readFile "wordsEN.txt"
    let words = fromList (lines file)
    putStrLn $ show $ member "hello" words -- force evaluation of the set
    putStrLn $ show $ correctList words (head args)